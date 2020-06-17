resource azurerm_monitor_log_profile "logging_profile" {
  categories = ["Action"]
  locations  = [var.location]
  name       = "terragoat-${var.environment}"
  retention_policy {
    enabled = true
    days    = 30
  }
}