output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "function_app_name" {
  value = azurerm_linux_function_app.function.name
}

output "function_app_hostname" {
  value = azurerm_linux_function_app.function.default_hostname
}

output "sql_server_fqdn" {
  value = azurerm_mssql_server.sql.fully_qualified_domain_name
}

output "sql_database_name" {
  value = azurerm_mssql_database.app.name
}

output "logic_app_id" {
  value = azurerm_logic_app_workflow.showcase.id
}
