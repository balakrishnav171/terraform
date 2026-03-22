terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  name_prefix = lower(replace(var.project_name, " ", "-"))
  common_tags = {
    environment = var.environment
    owner       = var.owner
    project     = var.project_name
    github      = var.github_profile_url
    managed_by  = "terraform"
  }
}

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

resource "random_password" "sql_admin" {
  length           = 20
  special          = true
  override_special = "!@#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = local.common_tags
}

module "networking" {
  source = "./modules/networking"

  name_prefix         = local.name_prefix
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  vnet_address_space  = var.vnet_address_space
  vm_subnet_cidr      = var.vm_subnet_cidr
  allowed_ssh_cidr    = var.allowed_ssh_cidr
  tags                = local.common_tags
}

module "compute" {
  source = "./modules/compute"

  location                = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  vm_size                 = var.vm_size
  vm_admin_username       = var.vm_admin_username
  vm_admin_ssh_public_key = var.vm_admin_ssh_public_key
  subnet_id               = module.networking.vm_subnet_id
  public_ip_name          = "${local.name_prefix}-vm-pip"
  network_interface_name  = "${local.name_prefix}-vm-nic"
  virtual_machine_name    = "${local.name_prefix}-vm"
  tags                    = local.common_tags
}

module "platform" {
  source = "./modules/platform"

  name_prefix                 = local.name_prefix
  resource_suffix             = random_string.suffix.result
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  storage_account_prefix      = var.storage_account_prefix
  function_app_python_version = var.function_app_python_version
  sql_admin_username          = var.sql_admin_username
  sql_admin_password          = random_password.sql_admin.result
  sql_database_sku            = var.sql_database_sku
  github_profile_url          = var.github_profile_url
  project_name                = var.project_name
  tags                        = local.common_tags
}
