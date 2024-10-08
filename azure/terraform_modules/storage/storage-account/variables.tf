variable storage_account_name {
    type = string
    description = "The name of the storage account"
}
variable resource_group_name {
    type = string
    description = "The name of the resource group"
}
variable location {
    type = string
    description = "The location of the resource group"
}
variable account_tier {
    type = string
    description = "The tier of the storage account"
}
variable account_replication_type {
    type = string
    description = "The replication type of the storage account"
}

variable shared_access_key_enabled {
    type = bool
    description = "Whether or not to enable shared access keys"
}

variable public_access_enabled {
    type = bool
    description = "Whether or not to enable public access"
}