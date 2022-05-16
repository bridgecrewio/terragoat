resource "azurerm_resource_group" "example" {
  name     = "terragoat-${var.environment}"
  location = var.location
}