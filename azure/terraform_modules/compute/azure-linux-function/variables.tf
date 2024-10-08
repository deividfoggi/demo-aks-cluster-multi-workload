variable resource_group_name {
    type = string
    description = "The name of the resource group in which to create the resources."
}
variable location {
    type = string
    description = "The location/region in which the resources will be created."
}
variable storage_account_name {
    type = string
    description = "The name of the storage account."
}
variable storage_account_access_key {
    type = string
    description = "The access key for the storage account."
}
variable service_plan_id {
    type = string
    description = "The ID of the App Service Plan."
}
variable linux_app_name {
    type = string
    description = "The name of the Linux App Service."
}