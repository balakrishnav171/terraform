output "resource_group_name" {
  description = "Resource group containing the showcase stack."
  value       = azurerm_resource_group.rg.name
}

output "virtual_network_name" {
  description = "Virtual network created for the showcase environment."
  value       = azurerm_virtual_network.vnet.name
}

output "vm_public_ip_address" {
  description = "Public IP address of the Linux VM."
  value       = azurerm_public_ip.vm.ip_address
}

output "storage_account_name" {
  description = "Storage account used for artifacts and Function App storage."
  value       = azurerm_storage_account.storage.name
}

output "function_app_name" {
  description = "Name of the deployed Azure Function App."
  value       = azurerm_linux_function_app.function.name
}

output "function_app_hostname" {
  description = "Default hostname for the Azure Function App."
  value       = azurerm_linux_function_app.function.default_hostname
}

output "sql_server_fqdn" {
  description = "FQDN of the Azure SQL logical server."
  value       = azurerm_mssql_server.sql.fully_qualified_domain_name
}

output "sql_database_name" {
  description = "Name of the Azure SQL database."
  value       = azurerm_mssql_database.app.name
}

output "sql_admin_password" {
  description = "Generated admin password for the Azure SQL server."
  value       = random_password.sql_admin.result
  sensitive   = true
}

output "logic_app_id" {
  description = "Resource ID of the Logic App workflow."
  value       = azurerm_logic_app_workflow.showcase.id
}
