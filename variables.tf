variable "project_name" {
  description = "Display name used to derive Azure resource names."
  type        = string
  default     = "github-showcase"
}

variable "owner" {
  description = "Tag value identifying the owner of this infrastructure."
  type        = string
  default     = "balakrishnavalluri"
}

variable "environment" {
  description = "Environment tag for the showcase deployment."
  type        = string
  default     = "demo"
}

variable "github_profile_url" {
  description = "GitHub profile or repository URL linked from the showcase resources."
  type        = string
  default     = "https://github.com/balakrishnav171"
}

variable "resource_group_name" {
  description = "Azure resource group name."
  type        = string
  default     = "rg-github-showcase-demo"
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "East US"
}

variable "vnet_address_space" {
  description = "CIDR block for the showcase virtual network."
  type        = string
  default     = "10.20.0.0/16"
}

variable "vm_subnet_cidr" {
  description = "CIDR block for the VM subnet."
  type        = string
  default     = "10.20.1.0/24"
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed to SSH into the virtual machine."
  type        = string
  default     = "0.0.0.0/0"
}

variable "vm_size" {
  description = "Azure VM size for the showcase instance."
  type        = string
  default     = "Standard_B2s"
}

variable "vm_admin_username" {
  description = "Admin username for the Linux VM."
  type        = string
  default     = "azureuser"
}

variable "vm_admin_ssh_public_key" {
  description = "SSH public key used for Linux VM access."
  type        = string
}

variable "storage_account_prefix" {
  description = "Lowercase prefix used for the storage account name."
  type        = string
  default     = "ghshowcase"
}

variable "function_app_python_version" {
  description = "Python runtime for the Linux Function App."
  type        = string
  default     = "3.10"
}

variable "sql_admin_username" {
  description = "Administrator login name for Azure SQL Server."
  type        = string
  default     = "sqladminuser"
}

variable "sql_database_sku" {
  description = "SKU name for the Azure SQL Database."
  type        = string
  default     = "Basic"
}
