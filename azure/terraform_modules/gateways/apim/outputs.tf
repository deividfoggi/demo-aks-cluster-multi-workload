output "private_ip_address" {
  value = azurerm_api_management.apim.private_ip_addresses[0]
}

output "principal_id" {
  value = azurerm_api_management.apim.identity[0].principal_id
}