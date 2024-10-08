resource "azurerm_cdn_frontdoor_route" "frontdoor_route" {
    name = var.name
    cdn_frontdoor_endpoint_id = var.cdn_frontdoor_endpoint_id
    cdn_frontdoor_origin_group_id = var.cdn_frontdoor_origin_group_id
    cdn_frontdoor_origin_ids = var.cdn_frontdoor_origin_ids
    cdn_frontdoor_rule_set_ids = var.cdn_frontdoor_rule_set_ids
    enabled = var.enabled

    forwarding_protocol = var.forwarding_protocol
    https_redirect_enabled = var.https_redirect_enabled
    patterns_to_match = var.patterns_to_match
    supported_protocols = var.supported_protocols

    cdn_frontdoor_custom_domain_ids = var.cdn_frontdoor_custom_domain_ids

    link_to_default_domain = false

    cache {
        query_string_caching_behavior = "UseQueryString"
        compression_enabled = true
        content_types_to_compress     = ["text/html", "text/javascript", "text/xml"]
    }
}