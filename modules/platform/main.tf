resource "azurerm_storage_account" "storage" {
  name                     = "${var.storage_account_prefix}${var.resource_suffix}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
  tags                     = var.tags
}

resource "azurerm_storage_container" "projects" {
  name                  = "project-artifacts"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_service_plan" "function" {
  name                = "${var.name_prefix}-func-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "Y1"
  tags                = var.tags
}

resource "azurerm_linux_function_app" "function" {
  name                = "${var.name_prefix}-func-${var.resource_suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.function.id

  storage_account_name       = azurerm_storage_account.storage.name
  storage_account_access_key = azurerm_storage_account.storage.primary_access_key
  https_only                 = true
  tags                       = var.tags

  site_config {
    application_stack {
      python_version = var.function_app_python_version
    }
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "python"
    WEBSITE_RUN_FROM_PACKAGE = "1"
    PROJECT_SHOWCASE_URL     = var.github_profile_url
  }
}

resource "azurerm_mssql_server" "sql" {
  name                         = "${var.name_prefix}-sql-${var.resource_suffix}"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
  minimum_tls_version          = "1.2"
  tags                         = var.tags
}

resource "azurerm_mssql_database" "app" {
  name      = "${var.name_prefix}-db"
  server_id = azurerm_mssql_server.sql.id
  sku_name  = var.sql_database_sku
  tags      = var.tags
}

resource "azurerm_logic_app_workflow" "showcase" {
  name                = "${var.name_prefix}-logic-app"
  location            = var.location
  resource_group_name = var.resource_group_name
  enabled             = true
  tags                = var.tags

  parameters = {
    projectName = jsonencode(
      {
        type         = "String"
        defaultValue = var.project_name
      }
    )
  }
}
