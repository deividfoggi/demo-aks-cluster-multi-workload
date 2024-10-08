variable "name" {
  description = "The name of the front door rule set"
  type        = string
}

variable "cdn_frontdoor_profile_id" {
  description = "The id of the CDN profile"
  type        = string
}