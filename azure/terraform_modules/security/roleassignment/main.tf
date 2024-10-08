resource "azurerm_role_assignment" "assignment" {
  scope                = var.scope_resource_id
  role_definition_name = var.role_definition_name
  principal_id         = var.principal_id
}