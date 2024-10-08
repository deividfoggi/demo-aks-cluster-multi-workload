variable "name" {
  description = "The name of the front door origin"
  type        = string
}

variable "cdn_frontdoor_origin_group_id" {
  description = "The id of the CDN origin group"
  type        = string
}

variable "enabled" {
  description = "Indicates whether the origin is enabled"
  type        = bool
}

variable "certificate_name_check_enabled" {
  description = "Indicates whether the origin is enabled"
  type        = bool
}

variable "host_name" {
  description = "The host name of the origin"
  type        = string
}

variable "http_port" {
  description = "The HTTP port of the origin"
  type        = number
}

variable "https_port" {
  description = "The HTTPS port of the origin"
  type        = number
}

variable "origin_host_header" {
  description = "The host header of the origin"
  type        = string
}

variable "priority" {
  description = "The priority of the origin"
  type        = number
}

variable "weight" {
  description = "The weight of the origin"
  type        = number
}

variable "private_link_request_message" {
  description = "The request message for the private link"
  type        = string
}

variable "location" {
  description = "The location of the private link"
  type        = string
}

variable "private_link_target_id" {
  description = "The id of the private link target"
  type        = string
}