variable "name" {
  description = "The name of the front door secret"
  type        = string
}

variable "cdn_frontdoor_profile_id" {
  description = "The id of the CDN profile"
  type        = string
}

variable "key_vault_certificate_id" {
  description = "The id of the key vault certificate"
  type        = string
}