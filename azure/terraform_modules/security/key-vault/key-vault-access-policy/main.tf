data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "key_vault_access_policy" {
  key_vault_id = var.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id

  # The object_id of the service principal
  object_id = var.service_principal_object_id

  secret_permissions = var.secret_permissions

  key_permissions = var.key_permissions

  certificate_permissions = var.certificate_permissions
}