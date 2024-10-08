resource "azurerm_cdn_frontdoor_custom_domain" "frontdoor_custom_domain" {
    name = var.name
    cdn_frontdoor_profile_id = var.cdn_frontdoor_profile_id
    dns_zone_id = var.dns_zone_id
    host_name = var.host_name

    tls {
        certificate_type = var.certificate_type
        minimum_tls_version = var.minimum_tls_version
        cdn_frontdoor_secret_id = var.frontdoor_secret_id
    }
}

resource "azurerm_cdn_frontdoor_custom_domain_association" "frontdoor_custom_domain_association" {
    cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.frontdoor_custom_domain.id
    cdn_frontdoor_route_ids = var.cdn_frontdoor_route_ids
}