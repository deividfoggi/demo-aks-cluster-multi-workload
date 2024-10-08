variable "name" {
  description = "The name of the Private Link Service"
  type        = string  
}

variable "resource_group_name" {
  description = "The name of the resource group in which the Private Link Service should be created"
  type        = string
}

variable "location" {
  description = "The location/region where the Private Link Service should be created"
  type        = string
}

variable "visibility_subscription_ids" {
  description = "A list of subscription IDs that should be able to access the Private Link Service"
  type        = list(string)
}

variable "load_balancer_frontend_ip_configuration_ids" {
  description = "A list of Load Balancer Frontend IP Configuration IDs that should be associated with the Private Link Service"
  type        = list(string)
}

variable "nat_ip_configuration_name" {
  description = "The name of the NAT IP Configuration"
  type        = string
}

variable "nat_ip_configuration_subnet_id" {
  description = "The ID of the Subnet where the NAT IP Configuration should be created"
  type        = string
}