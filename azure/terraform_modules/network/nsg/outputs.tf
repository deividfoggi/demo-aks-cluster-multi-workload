output "network_security_group_name" {
  value = azurerm_network_security_group.subnet_nsg.name
}

output "network_security_group_id" {
  value = azurerm_network_security_group.subnet_nsg.id
}