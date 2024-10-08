// create the open ai service
resource "azurerm_cognitive_account" "openai" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  kind                          = var.kind
  sku_name                      = var.sku
  custom_subdomain_name         = var.custom_subdomain_name
  network_acls {
    default_action = "Deny"
    ip_rules = []
    virtual_network_rules {
      ignore_missing_vnet_service_endpoint = var.network_acls_ignore_missing_endpoints
      subnet_id = var.network_acls_subnet_id
    }
  }
}