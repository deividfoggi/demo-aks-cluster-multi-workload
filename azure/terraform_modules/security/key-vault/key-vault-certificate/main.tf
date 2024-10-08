resource "azurerm_key_vault_certificate" "key_vault_certificate" {
    name = var.certificate_name
    key_vault_id = var.key_vault_id

    certificate {
        contents = filebase64(var.certificate_path)
        password = var.certificate_password
    }
}