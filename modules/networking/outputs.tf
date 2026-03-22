output "virtual_network_name" {
  value = azurerm_virtual_network.this.name
}

output "vm_subnet_id" {
  value = azurerm_subnet.vm.id
}
