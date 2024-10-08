resource "azurerm_linux_function_app" "linux_app" {
  name                = var.linux_app_name
  resource_group_name = var.resource_group_name
  location            = var.location

  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  service_plan_id            = var.service_plan_id

  site_config {}
}