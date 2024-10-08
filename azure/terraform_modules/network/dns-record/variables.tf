variable "name" {
  type = string
  description = "The name of the DNS record."
}

variable "zone_name" {
  type = string
  description = "The name of the private DNS zone."
}

variable "resource_group_name" {
  type = string
  description = "The name of the resource group in which to create the DNS record."
}

variable "ttl" {
  type = number
  description = "The TTL of the DNS record."
  default = 3600
}

variable "ip_address" {
  type = string
  description = "The IP address of the DNS record."
}