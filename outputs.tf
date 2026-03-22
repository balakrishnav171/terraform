output "resource_group_name" {
  description = "Resource group containing the showcase stack."
  value       = azurerm_resource_group.rg.name
}

output "virtual_network_name" {
  description = "Virtual network created for the showcase environment."
  value       = module.networking.virtual_network_name
}

output "vm_public_ip_address" {
  description = "Public IP address of the Linux VM."
  value       = module.compute.vm_public_ip_address
}

output "storage_account_name" {
  description = "Storage account used for artifacts and Function App storage."
  value       = module.platform.storage_account_name
}

output "function_app_name" {
  description = "Name of the deployed Azure Function App."
  value       = module.platform.function_app_name
}

output "function_app_hostname" {
  description = "Default hostname for the Azure Function App."
  value       = module.platform.function_app_hostname
}

output "sql_server_fqdn" {
  description = "FQDN of the Azure SQL logical server."
  value       = module.platform.sql_server_fqdn
}

output "sql_database_name" {
  description = "Name of the Azure SQL database."
  value       = module.platform.sql_database_name
}

output "sql_admin_password" {
  description = "Generated admin password for the Azure SQL server."
  value       = random_password.sql_admin.result
  sensitive   = true
}

output "logic_app_id" {
  description = "Resource ID of the Logic App workflow."
  value       = module.platform.logic_app_id
}
