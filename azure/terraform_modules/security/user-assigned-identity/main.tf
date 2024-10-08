resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  name                = var.prefix
  resource_group_name = var.resource_group_name
  location            = var.location
}