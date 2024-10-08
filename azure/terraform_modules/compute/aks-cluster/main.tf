resource "azurerm_kubernetes_cluster" "aks_cluster" {

  name                                = var.aks_cluster_name
  dns_prefix                          = var.aks_cluster_prefix
  resource_group_name                 = var.resource_group_name
  location                            = var.location
  sku_tier                            = var.aks_sku_tier
  node_resource_group                 = var.node_resource_group
  private_cluster_enabled             = true
  private_cluster_public_fqdn_enabled = false
  role_based_access_control_enabled   = true

  auto_scaler_profile {
    max_unready_nodes      = 250
    max_unready_percentage = 95
    expander               = "most-pods"
  }

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  default_node_pool {
    name                         = "system"
    vm_size                      = var.aks_system_nodepool_vmsize
    only_critical_addons_enabled = true
    enable_auto_scaling          = true
    min_count                    = 2
    max_count                    = 4
    os_disk_type                 = var.aks_os_disk_type
    vnet_subnet_id               = var.subnet_id
    zones                        = var.aks_cluster_zones
  }

  network_profile {
    network_plugin      = "azure"
    service_cidr        = "172.29.0.0/16"
    dns_service_ip      = "172.29.0.10"
    network_plugin_mode = "Overlay"
  }

  web_app_routing {
    dns_zone_ids = var.web_app_routing_dns_zone_ids
  }

  storage_profile {
    blob_driver_enabled = true
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      network_profile,
    ]
  }
}