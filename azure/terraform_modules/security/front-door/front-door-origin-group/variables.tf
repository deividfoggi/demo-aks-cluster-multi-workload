variable "cdn_frontdoor_profile_id" {
  description = "The name of the CDN profile"
  type        = string
}

variable "prefix" {
  description = "The prefix for the resources"
  type        = string
}

variable "session_affinity_enabled" {
  description = "Indicates whether session affinity is enabled"
  type        = bool
}

variable "restore_traffic_time_to_healed_or_new_endpoint_in_minutes" {
  description = "The time in minutes to restore traffic to a healed or new endpoint"
  type        = number
}

variable "health_probe_interval_in_seconds" {
  description = "The interval in seconds for the health probe"
  type        = number
}

variable "health_probe_path" {
  description = "The path for the health probe"
  type        = string
}

variable "health_probe_protocol" {
  description = "The protocol for the health probe"
  type        = string
}

variable "health_probe_request_type" {
  description = "The request type for the health probe"
  type        = string
}