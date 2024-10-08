variable "name" {
  type = string
  description = "The name of the application gateway."
}

variable "resource_group_name" {
  type = string
  description = "The name of the resource group in which to create the application gateway."
}

variable "location" {
  type = string
  description = "The location/region in which the application gateway will be created."
}

# Need to move it to a WAF module
variable "wafv2_policy_settings_enabled" {
  type = bool
  description = "Whether the policy settings are enabled."
  default = true
}
# Need to move it to a WAF module
variable "wafv2_policy_settings_mode" {
  type = string
  description = "The mode of the policy settings."
  default = "Detection"
}

variable "sku" {
  type = string
  description = "The SKU of the application gateway."
  default = "WAF_v2"
}

variable "sku_tier" {
  type = string
  description = "The tier of the SKU."
  default = "WAF_v2"
}

variable "subnet_id" {
  type = string
  description = "The ID of the subnet in which to deploy the application gateway."
}

variable "front_end_port" {
  type = number
  description = "The front end port of the application gateway."
}

variable "front_end_ip_id" {
  type = string
  description = "The name of the front end IP configuration."
}

variable "backend_address_fqdns" {
  type = list(string)
  description = "The fully qualified domain names of the backend address pool."
}

variable "http_settings_protocol" {
  type = string
  description = "The protocol of the HTTP settings."
  default = "Http"
}

variable "http_settings_cookie_based_affinity" {
  type = string
  description = "The cookie based affinity of the HTTP settings."
  default = "Enabled"
}

variable "http_settings_port" {
  type = number
  description = "The port of the HTTP settings."
}

variable "http_settings_request_timeout" {
  type = number
  description = "The request timeout of the HTTP settings."
  default = 600
}

variable "http_draining_enabled" {
  type = bool
  description = "Whether the connection draining is enabled."
  default = false
}

variable "http_draining_timeout" {
  type = number
  description = "The timeout of the connection draining."
  default = 60
}

variable "probe_protocol" {
  type = string
  description = "The protocol of the probe."
  default = "Https"
}

variable "probe_path" {
  type = string
  description = "The path of the probe."
}

variable "probe_interval" {
  type = number
  description = "The interval of the probe."
  default = 30
}

variable "probe_timeout" {
  type = number
  description = "The timeout of the probe."
  default = 30
}

variable "probe_unhealthy_threshold" {
  type = number
  description = "The unhealthy threshold of the probe."
  default = 3
}

variable "probe_pick_host_name_from_backend_http_settings" {
  type = bool
  description = "Whether to pick the host name from the backend HTTP settings."
  default = true
}

variable "ssl_certificate_name" {
  type = string
  description = "The name of the SSL certificate."
}

variable "ssl_certificate_data" {
  type = string
  description = "The data of the SSL certificate."
}

variable "ssl_certificate_password" {
  type = string
  sensitive = true
  description = "The password of the SSL certificate."
}

variable "http_listener_protocol" {
  type = string
  description = "The protocol of the HTTP listener."
  default = "Https"
}

variable "url_path_rule_paths" {
  type = list(string)
  description = "The paths of the URL path rule."
}

variable "request_routing_rule_type" {
  type = string
  description = "The type of the request routing rule."
  default = "PathBasedRouting"
}

variable "request_routing_rule_priority" {
  type = number
  description = "The priority of the request routing rule."
}