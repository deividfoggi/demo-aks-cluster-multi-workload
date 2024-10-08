resource "azurerm_cdn_frontdoor_endpoint" "frontdoor_endpoint" {
    name = "${var.prefix}-frontdoor-endpoint"
    cdn_frontdoor_profile_id = var.cdn_frontdoor_profile_id
}