// azure provider using latest version// azure provider using latest version
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.107.0"
    }

    azapi = {
      source = "Azure/azapi"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate4054"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azapi" { }

provider "azurerm" {
  features {
    cognitive_account {
      purge_soft_delete_on_destroy = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      recover_soft_deleted_certificates = true
    }
  }
}

data "azurerm_client_config" "current" {}

// create the resource group
module "resource_group" {
  source              = "../terraform_modules/core/resource-group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

// create the virtual network to host all the resources
module "virtual_network" {
  source                = "../terraform_modules/network/vnet"
  resource_group_name   = module.resource_group.resource_group_name
  location              = module.resource_group.location
  vnet_name             = var.vnet_name
  vnet_address_space    = var.vnet_address_space
}

// create the aks cluster subnet
module "aks_subnet" {
  source               = "../terraform_modules/network/subnet"
  name                 = "aks_subnet"
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.virtual_network.vnet_name
  address_prefixes     = [ var.aks_cluster_subnet_address_prefix ]
}

// create the ingress pls subnet
module "ingress_subnet" {
  source                                        = "../terraform_modules/network/subnet"
  name                                          = "ingress_subnet"
  resource_group_name                           = module.resource_group.resource_group_name
  virtual_network_name                          = module.virtual_network.vnet_name
  address_prefixes                              = [ var.ingress_node_pool_subnet_address_prefix ]
  private_link_service_network_policies_enabled = false
}

// create the private endpoints subnet
module "private_endpoints_subnet" {
  source               = "../terraform_modules/network/subnet"
  name                 = var.private_endpoints_subnet_name
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.virtual_network.vnet_name
  address_prefixes     = [var.private_endpoints_subnet_address_prefix]
}

// create the bastion subnet
module "bastion_subnet" {
  source               = "../terraform_modules/network/subnet"
  name                 = var.bastion_subnet_name
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.virtual_network.vnet_name
  address_prefixes     = [var.bastion_subnet_address_prefix]
}

// create the Jumpbox subnet
module "jumpbox_subnet" {
  source               = "../terraform_modules/network/subnet"
  name                 = var.jumpbox_subnet_name
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.virtual_network.vnet_name
  address_prefixes     = [var.jumpbox_subnet_address_prefix]
}

// create the bastion resource into the bastion subnet
module "bastion" {
  source                     = "../terraform_modules/compute/bastion_host"
  name                       = var.bastion_name
  resource_group_name        = module.resource_group.resource_group_name
  location                   = module.resource_group.location
  subnet_id                  = module.bastion_subnet.subnet_id
  log_analytics_workspace_id = module.log_analytics_workspace.log_analytics_workspace_id
}

// create the jumpbox VM into the jumpbox subnet
module "jumpbox" {
  source                              = "../terraform_modules/compute/virtual_machine"
  name                                = var.vm_name
  size                                = var.vm_size
  location                            = var.location
  public_ip                           = var.vm_public_ip
  vm_user                             = var.admin_username
  admin_ssh_public_key                = var.ssh_public_key
  os_disk_image                       = var.vm_os_disk_image
  domain_name_label                   = var.domain_name_label
  resource_group_name                 = module.resource_group.resource_group_name
  subnet_id                           = module.jumpbox_subnet.subnet_id
  os_disk_storage_account_type        = var.vm_os_disk_storage_account_type
  boot_diagnostics_storage_account    = var.script_storage_account_name
  log_analytics_workspace_id          = module.log_analytics_workspace.log_analytics_workspace_id
  log_analytics_workspace_key         = module.log_analytics_workspace.primary_shared_key
  log_analytics_workspace_resource_id = module.log_analytics_workspace.id
  script_storage_account_name         = module.app1_storage_account.storage_account_name
  script_storage_account_key          = module.app1_storage_account.primary_access_key
  container_name                      = var.container_name
  script_name                         = var.script_name
}

// create a log analytics workspace
module "log_analytics_workspace" {
  source                = "../terraform_modules/storage/log-analytics-workspace"
  name                  = var.log_analytics_workspace_name
  resource_group_name   = module.resource_group.resource_group_name
  location              = module.resource_group.location
  sku                   = var.log_analytics_workspace_sku
  retention_in_days     = var.log_analytics_workspace_retention_in_days
}

// create the aks cluster
module "aks_cluster" {
  source                       = "../terraform_modules/compute/aks-cluster"
  aks_cluster_name             = var.aks_cluster_name
  node_resource_group          = var.node_resource_group
  aks_cluster_prefix           = var.aks_cluster_prefix
  resource_group_name          = module.resource_group.resource_group_name
  location                     = module.resource_group.location
  aks_sku_tier                 = var.aks_sku_tier
  log_analytics_workspace_id   = module.log_analytics_workspace.log_analytics_workspace_id
  aks_system_nodepool_vmsize   = var.aks_system_nodepool_vmsize
  aks_os_disk_type             = var.aks_os_disk_type
  subnet_id                    = module.aks_subnet.subnet_id
  aks_cluster_zones            = var.aks_system_node_pool_zones
  web_app_routing_dns_zone_ids = [ module.app_private_dns_zone.private_dns_zone_id ]
}

// assign cluster identity network read permission on cluster subnet
resource "azurerm_role_assignment" "aks_cluster_identity_assignment" {
  scope                = module.virtual_network.vnet_id
  role_definition_name = "Network Contributor"
  principal_id         = module.aks_cluster.principal_id
}

// assign webapprouting-aks-cluster identity private dns zone contributor to the private dns zone
module "webapprouting_aks_cluster_identity_assignment" {
  source              = "../terraform_modules/security/roleassignment"
  scope_resource_id   = module.app_private_dns_zone.private_dns_zone_id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = module.aks_cluster.webapprouting_aks_cluster_object_id
}

// create apps node pool
module "apps_node_pool" {
  source            = "../terraform_modules/compute/aks-node-pool"
  node_pool_name    = var.user_node_pool_name
  aks_cluster_id    = module.aks_cluster.aks_cluster_id
  nodepool_vmsize   = var.user_node_pool_vmsize
  nodepool_priority = var.user_node_pool_priority
  min_count         = var.user_node_pool_min_count
  max_count         = var.user_node_pool_max_count
  max_pods          = var.user_node_pool_max_pods
  mode              = var.user_node_pool_mode
  os_disk_type      = var.user_node_pool_os_disk_type
  subnet_pool_id    = module.aks_subnet.subnet_id
  node_pool_zones   = var.aks_app_node_pool_zones
  app_label_taint   = "app"
}

// create the container registry
module "container_registry" {
  source              = "../terraform_modules/compute/azure-container-registry"
  name                = var.container_registry_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  sku                 = var.container_registry_sku
}

// create a private dns zone for the container registry private endpoint
module "acr_private_dns_zone" {
  source               = "../terraform_modules/network/private-dns-zone"
  name                 = "privatelink.azurecr.io"
  resource_group_name  = module.resource_group.resource_group_name
}

// create a private dns link to the container registry
module "acr_private_dns_link" {
  source               = "../terraform_modules/network/private-dns-zone-link"
  name                 = var.container_registry_private_dns_link_name
  private_dns_zone_name = module.acr_private_dns_zone.private_dns_zone_name
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_id   = module.virtual_network.vnet_id
  registration_enabled = false
}

// create a private endpoint for the container registry
module "acr_private_endpoint" {
  source                                  = "../terraform_modules/network/private-endpoint"
  name                                    = var.container_registry_private_endpoint_name
  location                                = module.resource_group.location
  resource_group_name                     = module.resource_group.resource_group_name
  private_connection_is_manual_connection = false
  dns_zone_group_name                     = "acr"
  dns_zone_id                             = module.acr_private_dns_zone.private_dns_zone_id
  subnet_id                               = module.private_endpoints_subnet.subnet_id
  private_connection_resource_id          = module.container_registry.id
  private_connection_subresource_names    = [ "registry" ]
  private_service_connection_name         = "acr"
}

// create a storage account for the app 1
module "app1_storage_account" {
  source                   = "../terraform_modules/storage/storage-account"
  storage_account_name     = var.app1_storage_account_name
  resource_group_name      = module.resource_group.resource_group_name
  location                 = module.resource_group.location
  account_tier             = var.app1_storage_account_tier
  account_replication_type = var.app1_storage_account_replication_type
  shared_access_key_enabled = var.app1_storage_account_allow_shared_key_access
  public_access_enabled     = var.app1_storage_account_public_access_enabled
}

module "app2_storage_account" {
  source                   = "../terraform_modules/storage/storage-account"
  storage_account_name     = var.app2_storage_account_name
  resource_group_name      = module.resource_group.resource_group_name
  location                 = module.resource_group.location
  account_tier             = var.app2_storage_account_tier
  account_replication_type = var.app2_storage_account_replication_type
  shared_access_key_enabled = var.app2_storage_account_allow_shared_key_access
  public_access_enabled     = var.app2_storage_account_public_access_enabled
}

// create the private dns zone for the storage account
module "storage_account_private_dns_zone" {
  source              = "../terraform_modules/network/private-dns-zone"
  name                = "blob.core.windows.net"
  resource_group_name = module.resource_group.resource_group_name
}

// create the private dns link for the storage accounts
module "storage_account_private_dns_link" {
  source                = "../terraform_modules/network/private-dns-zone-link"
  name                  = var.storage_account_private_dns_link_name
  private_dns_zone_name = module.storage_account_private_dns_zone.private_dns_zone_name
  resource_group_name   = module.resource_group.resource_group_name
  virtual_network_id    = module.virtual_network.vnet_id
  registration_enabled  = false
}

// create the private endpoint for the storage account of app1
module "app1_storage_account_private_endpoint" {
  source                                  = "../terraform_modules/network/private-endpoint"
  name                                    = var.app1_storage_account_private_endpoint_name
  location                                = module.resource_group.location
  resource_group_name                     = module.resource_group.resource_group_name
  private_connection_is_manual_connection = false
  dns_zone_group_name                     = var.app1_sa_dns_zone_group_name
  dns_zone_id                             = module.storage_account_private_dns_zone.private_dns_zone_id
  subnet_id                               = module.private_endpoints_subnet.subnet_id
  private_connection_resource_id          = module.app1_storage_account.id
  private_connection_subresource_names    = [ "blob" ]
  private_service_connection_name         = var.app1_sa_private_service_connection_name
}

// create the private endpoint for the storage account of app2
module "app2_storage_account_private_endpoint" {
  source                                  = "../terraform_modules/network/private-endpoint"
  name                                    = var.app2_storage_account_private_endpoint_name
  location                                = module.resource_group.location
  resource_group_name                     = module.resource_group.resource_group_name
  private_connection_is_manual_connection = false
  dns_zone_group_name                     = var.app2_sa_dns_zone_group_name
  dns_zone_id                             = module.storage_account_private_dns_zone.private_dns_zone_id
  subnet_id                               = module.private_endpoints_subnet.subnet_id
  private_connection_resource_id          = module.app1_storage_account.id
  private_connection_subresource_names    = [ "blob" ]
  private_service_connection_name         = var.app2_sa_private_service_connection_name
}

// create a private dns zone for app
module "app_private_dns_zone" {
  source              = "../terraform_modules/network/private-dns-zone"
  name                = var.app_private_dns_zone_name
  resource_group_name = module.resource_group.resource_group_name
}

// link the private dns zone for the app to the virtual network
module "app_private_dns_link" {
  source                = "../terraform_modules/network/private-dns-zone-link"
  name                  = "app_private_dns_link"
  private_dns_zone_name = module.app_private_dns_zone.private_dns_zone_name
  resource_group_name   = module.resource_group.resource_group_name
  virtual_network_id    = module.virtual_network.vnet_id
  registration_enabled  = false
}

// get the internal load balancer created on aks
data "azurerm_lb" "aks_internal_load_balancer" {
  name = "kubernetes-internal"
  resource_group_name = module.aks_cluster.node_resource_group

  depends_on = [ module.aks_cluster ]
}

#data "azurerm_lb" "load_balancer" {
#  name                = data.azurerm_resources.load_balancer_resource.name
#  resource_group_name = data.azurerm_resources.load_balancer_resource.resource_group
#}

// create the private link service in the ingress subnet to connect front door origin to the ingress load balancer
module "aks_ingress_private_link_service" {
  source                                      = "../terraform_modules/network/private-link-service"
  name                                        = var.private_link_service_name
  resource_group_name                         = module.resource_group.resource_group_name
  location                                    = module.resource_group.location

  visibility_subscription_ids                 = [ data.azurerm_client_config.current.subscription_id ]
  load_balancer_frontend_ip_configuration_ids = [ data.azurerm_lb.aks_internal_load_balancer.frontend_ip_configuration[0].id ]

  nat_ip_configuration_name                   = "aks_cluster_nat_ip_configuration"
  nat_ip_configuration_subnet_id              = module.ingress_subnet.subnet_id
}

// create front door profile
module "front_door_profile" {
  source              = "../terraform_modules/security/front-door/front-door-profile"
  prefix              = var.front_door_profile_prefix
  resource_group_name = module.resource_group.resource_group_name
  sku_name            = var.front_door_profile_sku_name

  depends_on = [ module.aks_ingress_private_link_service ]
}

// create the front door origin group
module "front_door_origin_group" {
  source                                                    = "../terraform_modules/security/front-door/front-door-origin-group"
  prefix                                                    = var.front_door_origin_group_prefix
  cdn_frontdoor_profile_id                                  = module.front_door_profile.id
  session_affinity_enabled                                  = true
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 5
  health_probe_interval_in_seconds                          = 30
  health_probe_path                                         = "/"
  health_probe_protocol                                     = "Http"
  health_probe_request_type                                 = "GET"
}

// create the front door origin
module "front_door_origin" {
  source                         = "../terraform_modules/security/front-door/front-door-origin"
  name                           = var.front_door_app_origin_name
  cdn_frontdoor_origin_group_id  = module.front_door_origin_group.id
  enabled                        = true
  certificate_name_check_enabled = true
  host_name                      = var.origin_private_dns_name
  http_port                      = 80
  https_port                     = 443
  origin_host_header             = var.origin_private_dns_name
  priority                       = 1
  weight                         = 1

  private_link_request_message   = "Please approve the private link connection to the front door origin"
  location                       = module.resource_group.location
  private_link_target_id         = module.aks_ingress_private_link_service.id

  depends_on = [ module.aks_ingress_private_link_service ]
}

// create front door endpoint
module "front_door_endpoint" {
  source                     = "../terraform_modules/security/front-door/front-door-endpoint"
  prefix                     = var.front_door_endpoint_prefix
  cdn_frontdoor_profile_id   = module.front_door_profile.id
}

// create front door ruleset
module "front_door_ruleset" {
  source                   = "../terraform_modules/security/front-door/front-door-rule-set"
  name                     = var.moodle_front_door_ruleset_name
  cdn_frontdoor_profile_id = module.front_door_profile.id
}

// create dns zone for the custom domain
module "app_dns_zone" {
  source              = "../terraform_modules/network/dns-zone"
  name                = var.front_door_custom_domain_host_name
  resource_group_name = module.resource_group.resource_group_name
}

// create front door custom domain
module "front_door_custom_domain" {
  source                   = "../terraform_modules/security/front-door/front-door-custom-domain"
  name                     = var.front_door_custom_domain_name
  cdn_frontdoor_profile_id = module.front_door_profile.id
  dns_zone_id              = module.app_dns_zone.id
  host_name                = var.front_door_custom_domain_host_name
  certificate_type         = "CustomerCertificate"
  minimum_tls_version      = "TLS12"
  frontdoor_secret_id      = module.front_door_secret.id
  cdn_frontdoor_route_ids  = [module.front_door_route.id]
}

// create front door route
module "front_door_route" {
  source                          = "../terraform_modules/security/front-door/front-door-route"
  name                            = var.front_door_route_name
  cdn_frontdoor_endpoint_id       = module.front_door_endpoint.id
  cdn_frontdoor_origin_group_id   = module.front_door_origin_group.id
  cdn_frontdoor_origin_ids        = [module.front_door_origin.id]
  cdn_frontdoor_rule_set_ids      = [module.front_door_ruleset.id]
  enabled                         = true
  forwarding_protocol             = "HttpOnly"
  https_redirect_enabled          = true
  patterns_to_match               = ["/"]
  supported_protocols             = ["Http", "Https"]
  cdn_frontdoor_custom_domain_ids = [module.front_door_custom_domain.id]

  depends_on = [ module.front_door_origin_group, module.front_door_origin ]
}

// create a key vault for Front Door
module "afd_key_vault" {
  source                        = "../terraform_modules/security/key-vault/key-vault"
  name                          = var.afd_key_vault_name
  resource_group_name           = module.resource_group.resource_group_name
  location                      = module.resource_group.location
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  public_network_access_enabled = var.afd_key_vault_public_network_access_enabled
}

// create a key vault for app1
module "app1_key_vault" {
  source                        = "../terraform_modules/security/key-vault/key-vault"
  name                          = var.app1_key_vault_name
  resource_group_name           = module.resource_group.resource_group_name
  location                      = module.resource_group.location
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  public_network_access_enabled = var.app1_key_vault_public_network_access_enabled
}

// create a key vault for app2
module "app2_key_vault" {
  source                        = "../terraform_modules/security/key-vault/key-vault"
  name                          = var.app2_key_vault_name
  resource_group_name           = module.resource_group.resource_group_name
  location                      = module.resource_group.location
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  public_network_access_enabled = var.app2_key_vault_public_network_access_enabled
}

// create the private dns zone for the key vault
module "key_vault_private_dns_zone" {
  source              = "../terraform_modules/network/private-dns-zone"
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = module.resource_group.resource_group_name
}

// create the private end point for the key vault of front door
module "afd_key_vault_private_endpoint" {
  source                                  = "../terraform_modules/network/private-endpoint"
  name                                    = var.afd_key_vault_private_endpoint_name
  location                                = module.resource_group.location
  resource_group_name                     = module.resource_group.resource_group_name
  private_connection_is_manual_connection = false
  dns_zone_group_name                     = var.afd_key_vault_dns_zone_group_name
  dns_zone_id                             = module.key_vault_private_dns_zone.private_dns_zone_id
  subnet_id                               = module.private_endpoints_subnet.subnet_id
  private_connection_resource_id          = module.afd_key_vault.id
  private_connection_subresource_names    = [ "vault" ]
  private_service_connection_name         = var.afd_key_vault_private_service_connection_name
}

// create the private end point for the key vault of app 1
module "app1_key_vault_private_endpoint" {
  source                                  = "../terraform_modules/network/private-endpoint"
  name                                    = var.app1_key_vault_private_endpoint_name
  location                                = module.resource_group.location
  resource_group_name                     = module.resource_group.resource_group_name
  private_connection_is_manual_connection = false
  dns_zone_group_name                     = var.app1_key_vault_dns_zone_group_name
  dns_zone_id                             = module.key_vault_private_dns_zone.private_dns_zone_id
  subnet_id                               = module.private_endpoints_subnet.subnet_id
  private_connection_resource_id          = module.app1_key_vault.id
  private_connection_subresource_names    = [ "vault" ]
  private_service_connection_name         = var.app1_key_vault_private_service_connection_name
}

// create the private end point for the key vault of app 2
module "app2_key_vault_private_endpoint" {
  source                                  = "../terraform_modules/network/private-endpoint"
  name                                    = var.app2_key_vault_private_endpoint_name
  location                                = module.resource_group.location
  resource_group_name                     = module.resource_group.resource_group_name
  private_connection_is_manual_connection = false
  dns_zone_group_name                     = var.app2_key_vault_dns_zone_group_name
  dns_zone_id                             = module.key_vault_private_dns_zone.private_dns_zone_id
  subnet_id                               = module.private_endpoints_subnet.subnet_id
  private_connection_resource_id          = module.app2_key_vault.id
  private_connection_subresource_names    = [ "vault" ]
  private_service_connection_name         = var.app2_key_vault_private_service_connection_name
}

// create an access policy for terraform service principal
module "terraform_key_vault_access_policy" {
  source                      = "../terraform_modules/security/key-vault/key-vault-access-policy"
  key_vault_id                = module.afd_key_vault.id
  service_principal_object_id = data.azurerm_client_config.current.object_id
  secret_permissions          = var.terraform_principal_key_vault_secret_permissions
  key_permissions             = var.terraform_principal_key_vault_key_permissions
  certificate_permissions     = var.terraform_principal_key_vault_certificate_permissions
}

// create an user assigned identity for front door
module "frontdoor_identity" {
  source               = "../terraform_modules/security/user-assigned-identity"
  prefix               = var.front_door_profile_prefix
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.location
}

# // create a role assignment to assign the identity of front door secrets access to the key vault
# resource "azurerm_role_assignment" "frontdoor_identity_assignment" {
#   scope                = module.afd_key_vault.id
#   role_definition_name = "Key Vault Secrets Officer"
#   principal_id         = module.frontdoor_identity.principal_id
# }

// create a role assignment to assign the identity of front door read access to the aks internal load balancer's private link service
resource "azurerm_role_assignment" "frontdoor_private_link_service_assignment" {
  scope                = module.aks_ingress_private_link_service.id
  role_definition_name = "Reader"
  principal_id         = module.frontdoor_identity.principal_id
}

// User azapi_update_resource to set the identity to the front door profile
resource "azapi_update_resource" "frontdoor_identity" {
  type = "Microsoft.Cdn/profiles@2024-02-01"
  resource_id = module.front_door_profile.id
  body = jsonencode({
    "identity": {
      "type": "UserAssigned",
      "userAssignedIdentities": {
        "${module.frontdoor_identity.id}": {}
      }
    }
  })
}

// create an access policy to allow frontdoor identity to access the key vault
module "frontdoor_key_vault_access_policy" {
  source                      = "../terraform_modules/security/key-vault/key-vault-access-policy"
  key_vault_id                = module.afd_key_vault.id
  service_principal_object_id = module.frontdoor_identity.principal_id
  secret_permissions          = var.frontdoor_principal_key_vault_secret_permissions
  key_permissions             = var.frontdoor_principal_key_vault_key_permissions
  certificate_permissions     = var.frontdoor_principal_key_vault_certificate_permissions
}

// create the certificate
module "afd_key_vault_certificate" {
  source               = "../terraform_modules/security/key-vault/key-vault-certificate"
  certificate_name     = var.ssl_certificate_name
  key_vault_id         = module.afd_key_vault.id
  certificate_path     = var.ssl_certificate_path
  certificate_password = var.ssl_certificate_password
}

# // create the front door secret
module "front_door_secret" {
  source                   = "../terraform_modules/security/front-door/front-door-secret"
  name                     = var.front_door_app_origin_name
  cdn_frontdoor_profile_id = module.front_door_profile.id
  key_vault_certificate_id = module.afd_key_vault_certificate.id
  depends_on               = [ module.frontdoor_identity, azapi_update_resource.frontdoor_identity ]
}

// create the subnet for the flexible server
module "flexible_server_subnet" {
  source               = "../terraform_modules/network/subnet"
  name                 = var.mysql_flexible_server_subnet_name
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.virtual_network.vnet_name
  address_prefixes     = [ var.mysql_flexible_server_subnet_address_prefix ]
  subnet_delegation_enabled = true
  delegation_name = "Microsoft.DBforMySQL/flexibleServers"
  service_delegation_name = "Microsoft.DBforMySQL/flexibleServers"
  service_delegation_actions = [ "Microsoft.Network/virtualNetworks/subnets/action" ]
}

// create the private dns zone for mysql flexible server
module "mysql_private_dns_zone" {
  source              = "../terraform_modules/network/private-dns-zone"
  name                = "mysql.database.azure.com"
  resource_group_name = module.resource_group.resource_group_name
}

// create the private dns link for the mysql flexible server
module "mysql_private_dns_link" {
  source                = "../terraform_modules/network/private-dns-zone-link"
  name                  = "mysql_private_dns_link"
  private_dns_zone_name = module.mysql_private_dns_zone.private_dns_zone_name
  resource_group_name   = module.resource_group.resource_group_name
  virtual_network_id    = module.virtual_network.vnet_id
  registration_enabled  = true
}

// create a random password for the mysql flexible server
resource "random_password" "mysql_administrator_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

// create the mysql flexible server
module "mysql_flexible_server" {
  source                 = "../terraform_modules/azure-database/mysql-flexible/server"
  name                   = var.mysql_flexible_server_name
  resource_group_name    = module.resource_group.resource_group_name
  location               = module.resource_group.location
  administrator_login    = var.mysql_flexible_server_admin_username
  administrator_password = random_password.mysql_administrator_password.result
  backup_retention_days  = var.mysql_backup_retention_days
  delegated_subnet_id    = module.flexible_server_subnet.subnet_id
  private_dns_zone_id    = module.app_private_dns_zone.private_dns_zone_id
  sku_name               = var.mysql_sku_name
  zone                   = var.mysql_flexible_server_zone

  depends_on = [ module.mysql_private_dns_link ]
  }

// creathe the mysql database
module "mysql_flexible_database" {
  source              = "../terraform_modules/azure-database/mysql-flexible/database"
  name                = var.mysql_database_name
  resource_group_name = module.resource_group.resource_group_name
  mysql_server_name   = module.mysql_flexible_server.name
  charset             = var.mysql_database_charset
  collation           = var.mysql_database_collation
}