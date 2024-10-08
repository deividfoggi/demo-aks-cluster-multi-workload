resource "azurerm_kubernetes_cluster_node_pool" "aks_cluster" {
  name                  = var.node_pool_name
  kubernetes_cluster_id = var.aks_cluster_id
  vm_size               = var.nodepool_vmsize
  priority              = var.nodepool_priority
  enable_auto_scaling   = true
  min_count             = var.min_count
  max_count             = var.max_count
  max_pods              = var.max_pods
  mode                  = var.mode
  os_disk_type          = var.os_disk_type
  vnet_subnet_id        = var.subnet_pool_id
  zones                 = var.node_pool_zones
  eviction_policy       = var.nodepool_priority == "Spot" ? "Delete" : null
  node_taints           = var.nodepool_priority == "Spot" ? [ "kubernetes.azure.com/scalesetpriority=spot:NoSchedule", "app=${var.app_label_taint}:NoSchedule" ] : [ "app=${var.app_label_taint}:NoSchedule" ]
  node_labels           = var.nodepool_priority == "Spot" ? { "kubernetes.azure.com/scalesetpriority" = "spot" } : null       
} 