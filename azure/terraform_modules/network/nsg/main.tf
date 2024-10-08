resource "azurerm_network_security_group" "subnet_nsg" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
}