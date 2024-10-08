variable "name" {
  description = "The name of the front door route"
  type        = string
}

variable "cdn_frontdoor_endpoint_id" {
  description = "The id of the CDN profile"
  type        = string
}

variable "cdn_frontdoor_origin_group_id" {
  description = "The id of the CDN frontdoor origin group"
  type        = string
}

variable "cdn_frontdoor_origin_ids" {
  description = "The id of the CDN frontdoor origin"
  type        = list(string)
}

variable "cdn_frontdoor_rule_set_ids" {
  description = "The id of the CDN frontdoor rule set"
  type        = list(string)
}

variable "enabled" {
  description = "The enabled state"
  type        = string
}

variable "forwarding_protocol" {
  description = "The forwarding protocol"
  type        = string
}

variable "https_redirect_enabled" {
  description = "The HTTPS redirect enabled"
  type        = bool
}

variable "patterns_to_match" {
  description = "The patterns to match"
  type        = list(string)
}

variable "supported_protocols" {
  description = "The supported protocols"
  type        = list(string)
}

variable "cdn_frontdoor_custom_domain_ids" {
  description = "The id of the CDN frontdoor custom domain"
  type        = list(string)
}
