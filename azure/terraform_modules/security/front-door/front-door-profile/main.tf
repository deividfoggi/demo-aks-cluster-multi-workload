resource "azurerm_cdn_frontdoor_profile" "frontdoor" {
    name                = "${var.prefix}-frontdoor"
    resource_group_name = var.resource_group_name
    sku_name            = var.sku_name
}