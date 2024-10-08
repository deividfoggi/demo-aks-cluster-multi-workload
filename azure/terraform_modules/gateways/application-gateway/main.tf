// create an azure application gateway inside the apgw subnet
locals {
    backend_pool_name = "${var.name}-backend-pool"
    backend_http_settings_name = "${var.name}-backend-http-settings"
    http_listener_name = "${var.name}-http-listener"
    url_path_map_name = "${var.name}-url-path-map"
    ip_config_name = "${var.name}-ip-config"
    frontend_port_name = "${var.name}-frontend-port"
    probe_name = "apgw_apim_probe"
}

// create the WAFv2 policy
resource "azurerm_web_application_firewall_policy" "apgw_waf_policy" {
  name                = "${var.name}-waf-policy"
  resource_group_name = var.resource_group_name
  location            = var.location

  policy_settings {
    enabled = var.wafv2_policy_settings_enabled
    mode    = var.wafv2_policy_settings_mode
  }

  managed_rules {
    managed_rule_set {
      type = "OWASP"
      version = "3.2"
    }
  
  }
}

resource "azurerm_application_gateway" "apgw" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  
  sku {
    name     = var.sku
    tier     = var.sku_tier
    capacity = 1
  }
  
  gateway_ip_configuration {
    name      = "${var.name}_ip_config"
    subnet_id = var.subnet_id
  }
  
  frontend_port {
    name = local.frontend_port_name
    port = var.front_end_port
  }

  frontend_ip_configuration {
    name                 = local.ip_config_name
    public_ip_address_id = var.front_end_ip_id
  }

  backend_address_pool {
    name  = local.backend_pool_name
    fqdns =  var.backend_address_fqdns
  }

  backend_http_settings {
    name                      = local.backend_http_settings_name
    protocol                  = var.http_settings_protocol
    port                      = var.http_settings_port
    cookie_based_affinity     = var.http_settings_cookie_based_affinity
    request_timeout           = var.http_settings_request_timeout
    connection_draining {
      enabled = var.http_draining_enabled
      drain_timeout_sec = var.http_draining_timeout
    }
    pick_host_name_from_backend_address = true
    probe_name = local.probe_name
  }
  
  probe {
    name = local.probe_name
    protocol = var.probe_protocol
    #path = "/status-0123456789abcdef"
    path = var.probe_path
    interval = var.probe_interval
    timeout = var.probe_timeout
    unhealthy_threshold = var.probe_unhealthy_threshold
    pick_host_name_from_backend_http_settings = var.probe_pick_host_name_from_backend_http_settings 
  }


  ssl_certificate {
    name     = var.ssl_certificate_name
    data     = filebase64(var.ssl_certificate_data)
    password = var.ssl_certificate_password
  }

  http_listener {
    name                                = local.http_listener_name
    frontend_ip_configuration_name      = local.ip_config_name
    frontend_port_name                  = local.frontend_port_name
    protocol                            = var.http_listener_protocol
    ssl_certificate_name                = var.ssl_certificate_name
    
  }

  url_path_map {
    name                = local.url_path_map_name
    default_backend_address_pool_name = local.backend_pool_name
    default_backend_http_settings_name = local.backend_http_settings_name
    path_rule {
        name            = local.url_path_map_name
        paths           = var.url_path_rule_paths
        backend_http_settings_name = local.backend_http_settings_name
        backend_address_pool_name = local.backend_pool_name
    } 
  }

  request_routing_rule {
    name                       = "apgw_request_routing_rule"
    rule_type                  = "PathBasedRouting"
    http_listener_name         = local.http_listener_name
    url_path_map_name          = local.url_path_map_name
    priority = 1
    }

    firewall_policy_id = azurerm_web_application_firewall_policy.apgw_waf_policy.id
}