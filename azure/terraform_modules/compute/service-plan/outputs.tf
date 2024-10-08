output "service_plan_id" {
  value = "${element(concat(azurerm_service_plan.example.*.id, list("")), 0)}"
}