variable "name" {
  description = "The name of the front door custom domain"
  type        = string
}

variable "cdn_frontdoor_profile_id" {
  description = "The id of the CDN profile"
  type        = string
}

variable "dns_zone_id" {
  description = "The DNS name of the custom domain"
  type        = string
}

variable "host_name" {
  description = "The host name of the custom domain"
  type        = string
}

variable "certificate_type" {
  description = "The type of the certificate"
  type        = string
}

variable "minimum_tls_version" {
  description = "The minimum TLS version"
  type        = string
}

variable "frontdoor_secret_id" {
  description = "The id of the frontdoor secret"
  type        = string
}

variable "cdn_frontdoor_route_ids" {
  description = "The id of the CDN frontdoor route"
  type        = list(string)
}