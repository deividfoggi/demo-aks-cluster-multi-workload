// variable for a prefix to be used on all resources name
variable "prefix" {
  type        = string
  description = "A prefix to be used on all resources name."
  default     = "dfoggi"
}

// variable for resource group name
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the resources will be created."
  default     = "apim-openai-demo-rg"
}

// variable for location
variable "location" {
  type        = string
  description = "The location/region where the resources will be created."
  default     = "eastus"
}

// variable for virtual network name
variable "vnet_name" {
  type        = string
  description = "The name of the virtual network."
  default     = "vnet"
}

// variable for virtual network address space
variable "vnet_address_space" {
  type        = list(string)
  description = "The address space that is used the virtual network."
  default     = []
}

// variable for private endpoints subnet name
variable "private_endpoints_subnet_name" {
  type        = string
  description = "The name of the subnet for the private endpoints."
  default     = "private_endpoints_subnet"
}

variable "bastion_name" {
  type        = string
  description = "The name of the bastion host."
  default     = "bastion"
}

variable "bastion_subnet_name" {
  type        = string
  description = "The name of the subnet for the bastion host."
  default     = "bastion_subnet"
}

variable "bastion_subnet_address_prefix" {
  type        = string
  description = "The address prefix for the subnet for the bastion host."
  default     = ""
}

variable "jumpbox_subnet_name" {
  type        = string
  description = "The name of the subnet for the jumpbox."
  default     = "jumpbox_subnet"
}

variable "jumpbox_subnet_address_prefix" {
  type        = string
  description = "The address prefix for the subnet for the jumpbox."
  default     = ""
}

// variable for private endpoints subnet address prefix
variable "private_endpoints_subnet_address_prefix" {
  type        = string
  description = "The address prefix for the subnet for the private endpoints."
  default     = ""
}

variable "aks_cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "node_resource_group" {
  description = "The name of the nodes/infra resource group"
  type        = string
}

variable "aks_cluster_prefix" {
  description = "The DNS prefix for the AKS cluster"
  type        = string
}

variable "aks_cluster_subnet_address_prefix" {
  description = "The address prefix for the AKS cluster subnet"
  type        = string
}

variable "aks_sku_tier" {
  description = "The SKU tier of the AKS cluster"
  type        = string
}

variable "aks_system_nodepool_vmsize" {
  description = "The VM size of the system node pool"
  type        = string
}

variable "aks_system_node_pool_zones" {
  description = "The zones of the AKS node pool"
  type        = list(string)
}

variable "aks_app_node_pool_zones" {
  description = "The name of the AKS node pool"
  type        = list(string)
}

variable "aks_ingress_node_pool_zones" {
  description = "The name of the AKS node pool"
  type        = list(string)
}

variable "ingress_node_pool_subnet_address_prefix" {
  description = "The address prefix for the ingress node pool subnet"
  type        = string
}

variable "aks_os_disk_type" {
  description = "The OS disk type of the AKS cluster"
  type        = string
}

variable "user_node_pool_name" {
  description = "The name of the AKS node pool"
  type        = string
}

variable "user_node_pool_vmsize" {
  description = "The VM size of the AKS node pool"
  type        = string
}

variable "user_node_pool_priority" {
  description = "The priority of the AKS node pool"
  type        = string
}

variable "user_node_pool_min_count" {
  description = "The minimum count of the AKS node pool"
  type        = number
}

variable "user_node_pool_max_count" {
  description = "The maximum count of the AKS node pool"
  type        = number
}

variable "user_node_pool_max_pods" {
  description = "The maximum pods of the AKS node pool"
  type        = number
}

variable "user_node_pool_mode" {
  description = "The mode of the AKS node pool"
  type        = string
}

variable "user_node_pool_os_disk_type" {
  description = "The OS disk type of the AKS node pool"
  type        = string
}

variable "ingress_node_pool_name" {
  description = "The name of the AKS node pool"
  type        = string
}

variable "ingress_node_pool_vmsize" {
  description = "The VM size of the AKS node pool"
  type        = string
}

variable "ingress_node_pool_priority" {
  description = "The priority of the AKS node pool"
  type        = string
}

variable "ingress_node_pool_min_count" {
  description = "The minimum count of the AKS node pool"
  type        = number
}

variable "ingress_node_pool_max_count" {
  description = "The maximum count of the AKS node pool"
  type        = number
}

variable "ingress_node_pool_max_pods" {
  description = "The maximum pods of the AKS node pool"
  type        = number
}

variable "ingress_node_pool_mode" {
  description = "The mode of the AKS node pool"
  type        = string
}

variable "ingress_node_pool_os_disk_type" {
  description = "The OS disk type of the AKS node pool"
  type        = string
}

// variable for log analytics workspace name
variable "log_analytics_workspace_name" {
  type        = string
  description = "The name of the Log Analytics workspace."
  default     = "loganalytics"
}

// variable for log analytics workspace sku
variable "log_analytics_workspace_sku" {
  type        = string
  description = "The SKU of the Log Analytics workspace."
  default     = "PerGB2018"
}

variable "log_analytics_workspace_retention_in_days" {
  type        = number
  description = "The retention period for the logs in days."
  default     = 30 
}

variable "container_registry_name" {
  description = "The name of the Azure Container Registry"
  type        = string
}

variable "container_registry_sku" {
  description = "The SKU of the Azure Container Registry"
  type        = string
}

variable "container_registry_private_endpoint_name" {
  description = "The name of the private endpoint for the Azure Container Registry"
  type        = string
}

variable "container_registry_private_dns_link_name" {
  description = "The name of the private DNS link for the Azure Container Registry"
  type        = string
}

variable "ssl_certificate_path" {
  type        = string
  description = "The data for the SSL certificate."
}

variable "ssl_certificate_name" {
  type        = string
  description = "The name of the SSL certificate."
}

variable "ssl_certificate_password" {
  type        = string
  description = "The password for the SSL certificate."
}

variable "app1_storage_account_name" {
  type        = string
  description = "The name of the storage account for the app."
}

variable "app1_storage_account_tier" {
  type        = string
  description = "The tier of the storage account."
}

variable "app1_storage_account_replication_type" {
  type        = string
  description = "The replication type of the storage account." 
}

variable "app1_storage_account_allow_shared_key_access" {
  type        = bool
  description = "Allow shared key access to the storage account."
}

variable "app1_storage_account_public_access_enabled" {
  type        = bool
  description = "Allow public access to the storage account." 
}

variable "app1_storage_account_private_endpoint_name" {
  type        = string
  description = "The name of the private endpoint for the storage account."
}

variable "app1_sa_dns_zone_group_name" {
  type        = string
  description = "The name of the DNS zone group."
}


variable "app1_sa_private_service_connection_name" {
  type        = string
  description = "The name of the private service connection."
}

variable "app2_storage_account_name" {
  type        = string
  description = "The name of the storage account for the app."
}

variable "app2_storage_account_tier" {
  type        = string
  description = "The tier of the storage account."
}

variable "app2_storage_account_replication_type" {
  type        = string
  description = "The replication type of the storage account." 
}

variable "app2_storage_account_allow_shared_key_access" {
  type        = bool
  description = "Allow shared key access to the storage account."
}

variable "app2_storage_account_public_access_enabled" {
  type        = bool
  description = "Allow public access to the storage account." 
}

variable "app2_storage_account_private_endpoint_name" {
  type        = string
  description = "The name of the private endpoint for the storage account."
}

variable "app2_sa_dns_zone_group_name" {
  type        = string
  description = "The name of the DNS zone group."
}


variable "app2_sa_private_service_connection_name" {
  type        = string
  description = "The name of the private service connection."
}

variable "storage_account_private_dns_link_name" {
  type        = string
  description = "The name of the private DNS link for the storage account."
}

variable "afd_key_vault_name" {
  type        = string
  description = "The prefix for the key vault."
}

variable "afd_key_vault_public_network_access_enabled" {
  type        = bool
  description = "Whether or not to enable public network access for the key vault."
}

variable "afd_key_vault_private_endpoint_name" {
  type        = string
  description = "The name of the private endpoint for the key vault."
}

variable "afd_key_vault_dns_zone_group_name" {
  type        = string
  description = "The name of the DNS zone group."
}

variable "afd_key_vault_private_service_connection_name" {
  type        = string
  description = "The name of the private service connection."
}

variable "app1_key_vault_name" {
  type        = string
  description = "The prefix for the key vault."
}

variable "app1_key_vault_public_network_access_enabled" {
  type        = bool
  description = "Whether or not to enable public network access for the key vault."
}

variable "app1_key_vault_private_endpoint_name" {
  type        = string
  description = "The name of the private endpoint for the key vault."
}

variable "app1_key_vault_dns_zone_group_name" {
  type        = string
  description = "The name of the DNS zone group."
}

variable "app1_key_vault_private_service_connection_name" {
  type        = string
  description = "The name of the private service connection."
}

variable "app2_key_vault_name" {
  type        = string
  description = "The prefix for the key vault."
}

variable "app2_key_vault_public_network_access_enabled" {
  type        = bool
  description = "Whether or not to enable public network access for the key vault."
}

variable "app2_key_vault_private_endpoint_name" {
  type        = string
  description = "The name of the private endpoint for the key vault."
}

variable "app2_key_vault_dns_zone_group_name" {
  type        = string
  description = "The name of the DNS zone group."
}

variable "app2_key_vault_private_service_connection_name" {
  type        = string
  description = "The name of the private service connection."
}

variable "terraform_principal_key_vault_secret_permissions" {
  type        = list(string)
  description = "The permissions for the Terraform principal on the key vault."
}

variable "terraform_principal_key_vault_certificate_permissions" {
  type        = list(string)
  description = "The permissions for the Terraform principal on the key vault."
}

variable "terraform_principal_key_vault_key_permissions" {
  type        = list(string)
  description = "The permissions for the Terraform principal on the key vault."
}

variable "frontdoor_principal_key_vault_secret_permissions" {
  type        = list(string)
  description = "The permissions for the Terraform principal on the key vault."
}

variable "frontdoor_principal_key_vault_certificate_permissions" {
  type        = list(string)
  description = "The permissions for the Terraform principal on the key vault."
}

variable "frontdoor_principal_key_vault_key_permissions" {
  type        = list(string)
  description = "The permissions for the Terraform principal on the key vault."
}

variable "private_link_service_name" {
  type        = string
  description = "The name of the private link service."
}

variable "front_door_profile_prefix" {
  type        = string
  description = "The name of the front door profile."
}

variable "front_door_profile_sku_name" {
  type        = string
  description = "The SKU of the front door profile."
}

variable "front_door_origin_group_prefix" {
  type        = string
  description = "The name of the front door origin group."
}

variable "front_door_endpoint_prefix" {
  type        = string
  description = "The name of the front door endpoint."
}

variable "front_door_app_origin_name" {
  type        = string
  description = "The name of the front door app origin."
}

variable "front_door_app_origin_host" {
  type        = string
  description = "The host name of the front door app origin."
}

variable "origin_private_dns_name" {
  type        = string
  description = "The name of the private DNS zone for the origin."
}

variable "moodle_front_door_ruleset_name" {
  type        = string
  description = "The name of the front door rule set."
}

variable "front_door_custom_domain_name" {
  type        = string
  description = "The host name of the front door custom domain."
}

variable "front_door_custom_domain_host_name" {
  type        = string
  description = "The host name of the front door custom domain."
}

variable "front_door_route_name" {
  type        = string
  description = "The name of the front door route."
}

variable "app_private_dns_zone_name" {
  type        = string
  description = "The name of the private DNS zone for the app."
}

variable "mysql_flexible_server_subnet_name" {
  type        = string
  description = "The name of the subnet for the flexible server."
}

variable "mysql_flexible_server_subnet_address_prefix" {
  type        = string
  description = "The address prefix for the subnet for the flexible server."
}

variable "mysql_flexible_server_name" {
  type        = string
  description = "The name of the flexible server."
}

variable "mysql_flexible_server_sku_name" {
  type        = string
  description = "The SKU name for the MySQL server."
}

variable "mysql_flexible_server_storage_mb" {
  type        = number
  description = "The storage capacity of the MySQL server."
}

variable "mysql_flexible_server_version" {
  type        = string
  description = "The version of the MySQL server."
}

variable "mysql_flexible_server_admin_username" {
  type        = string
  description = "The administrator login for the MySQL server."
}
variable "mysql_backup_retention_days" {
  type        = number
  description = "The backup retention days for the MySQL server."
}

variable "mysql_sku_name" {
  type        = string
  description = "The SKU name for the MySQL server."
}

variable "mysql_flexible_server_zone" {
  type        = string
  description = "The zones of the MySQL server."
}

variable "mysql_database_name" {
  type        = string
  description = "The name of the MySQL database."
}

variable "mysql_database_charset" {
  type        = string
  description = "The charset for the MySQL database."
}

variable "mysql_database_collation" {
  type        = string
  description = "The collation for the MySQL database."
}

variable "vm_name" {
  description = "Specifies the name of the jumpbox virtual machine"
  default     = "TestVm"
  type        = string
}

variable "domain_name_label" {
  description = "Specifies the domain name for the jumbox virtual machine"
  default     = "contoso"
  type        = string
}

variable "vm_public_ip" {
  description = "(Optional) Specifies whether create a public IP for the virtual machine"
  type = bool
  default = false
}

variable "vm_size" {
  description = "Specifies the size of the jumpbox virtual machine"
  default     = "Standard_DS1_v2"
  type        = string
}

variable "admin_username" {
  description = "(Required) Specifies the admin username of the jumpbox virtual machine and AKS worker nodes."
  type        = string
  default     = "azadmin"
}

variable "ssh_public_key" {
  description = "(Required) Specifies the SSH public key for the jumpbox virtual machine and AKS worker nodes."
  type        = string
}

variable "vm_os_disk_storage_account_type" {
  description = "Specifies the storage account type of the os disk of the jumpbox virtual machine"
  default     = "Premium_LRS"
  type        = string

  validation {
    condition = contains(["Premium_LRS", "Premium_ZRS", "StandardSSD_LRS", "StandardSSD_ZRS",  "Standard_LRS"], var.vm_os_disk_storage_account_type)
    error_message = "The storage account type of the OS disk is invalid."
  }
}

variable "vm_os_disk_image" {
  type        = map(string)
  description = "Specifies the os disk image of the virtual machine"
  default     = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2" 
    version   = "latest"
  }
}

variable "script_storage_account_name" {
  description = "(Required) Specifies the name of the storage account that contains the custom script."
  type        = string
}

variable "script_storage_account_key" {
  description = "(Required) Specifies the name of the storage account that contains the custom script."
  type        = string
}

variable "container_name" {
  description = "(Required) Specifies the name of the container that contains the custom script."
  type        = string
  default     = "scripts"
}

variable "script_name" {
  description = "(Required) Specifies the name of the custom script."
  type        = string
  default     = "configure-jumpbox-vm.sh"
}