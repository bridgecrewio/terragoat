resource "azurerm_sql_firewall_rule" "example" {
  name                = "office"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_sql_server.example.name
  start_ip_address    = "40.112.8.12"
  end_ip_address      = "40.112.8.12"
}

resource "azurerm_sql_server" "example" {
  name                         = "terragoat-kmssqlserver-${var.environment}"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = "ariel"
  administrator_login_password = "Aa12345678"
  tags = {
    environment = var.environment
    terragoat   = "true"

  }
}