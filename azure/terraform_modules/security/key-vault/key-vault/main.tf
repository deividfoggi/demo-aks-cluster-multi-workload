resource "azurerm_key_vault" "key_vault" {
    name                          = var.name
    location                      = var.location
    resource_group_name           = var.resource_group_name
    tenant_id                     = var.tenant_id
    soft_delete_retention_days    = 7
    purge_protection_enabled      = false
    public_network_access_enabled = var.public_network_access_enabled
    sku_name                      = "standard"
}