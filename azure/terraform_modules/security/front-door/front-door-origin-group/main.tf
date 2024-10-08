resource "azurerm_cdn_frontdoor_origin_group" "frontdoor_origin_group" {
    
    name                = "${var.prefix}-frontdoor-origin-group"
    cdn_frontdoor_profile_id = var.cdn_frontdoor_profile_id
    session_affinity_enabled = var.session_affinity_enabled

    restore_traffic_time_to_healed_or_new_endpoint_in_minutes = var.restore_traffic_time_to_healed_or_new_endpoint_in_minutes

    health_probe {
        interval_in_seconds = var.health_probe_interval_in_seconds
        path = var.health_probe_path
        protocol = var.health_probe_protocol
        request_type = var.health_probe_request_type
    }

    load_balancing {
        additional_latency_in_milliseconds = 0
        sample_size = 16
        successful_samples_required = 3
    }

}