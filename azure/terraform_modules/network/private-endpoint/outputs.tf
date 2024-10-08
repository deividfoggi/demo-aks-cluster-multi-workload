output "private_endpoint_ip_address" {
  value = azurerm_private_endpoint.private_endpoints_subnet.private_service_connection[0].private_ip_address
}