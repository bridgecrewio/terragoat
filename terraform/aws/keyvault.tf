resource "azurerm_key_vault_secret" "secret" {
  key_vault_id = azurerm_key_vault.example.id
  name         = "terragoat-secret-${var.environment}"
  value        = random_string.password.result
  tags = {
    name      = "zs"
    owner     = ""
    zs-key    = "new1"
    yor_trace = "3cace663-fd92-4f09-b130-ce226b91316a"
  }
}
