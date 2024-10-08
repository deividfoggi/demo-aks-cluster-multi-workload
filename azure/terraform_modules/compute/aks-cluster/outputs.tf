output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.id
}

output "node_resource_group" {
  value = azurerm_kubernetes_cluster.aks_cluster.node_resource_group
}

output "principal_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.identity.0.principal_id
}

output "webapprouting_aks_cluster_object_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.web_app_routing.0.web_app_routing_identity.0.object_id
}