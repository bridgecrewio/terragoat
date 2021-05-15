resource "azurerm_managed_disk" "example" {
  name                 = "terragoat-disk-${var.environment}"
  location             = var.location
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 1
  encryption_settings {
    enabled = false
  }
  tags = {
    git_commit           = "d68d2897add9bc2203a5ed0632a5cdd8ff8cefb0"
    git_file             = "terraform/azure/storage.tf"
    git_last_modified_at = "2020-06-16 14:46:24"
    git_last_modified_by = "nimrodkor@gmail.com"
    git_modifiers        = "nimrodkor"
    git_org              = "try-bridgecrew"
    git_repo             = "terragoat"
    yor_trace            = "414b46d1-e217-4c9c-a3e1-c41429e81a99"
  }
}

resource "azurerm_storage_account" "example" {
  name                     = "tgsa${var.environment}${random_integer.rnd_int.result}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  queue_properties {
    logging {
      delete                = false
      read                  = false
      write                 = true
      version               = "1.0"
      retention_policy_days = 10
    }
    hour_metrics {
      enabled               = true
      include_apis          = true
      version               = "1.0"
      retention_policy_days = 10
    }
    minute_metrics {
      enabled               = true
      include_apis          = true
      version               = "1.0"
      retention_policy_days = 10
    }
  }
  tags = {
    git_commit           = "81738b80d571fa3034633690d13ffb460e1e7dea"
    git_file             = "terraform/azure/storage.tf"
    git_last_modified_at = "2020-06-19 21:14:50"
    git_last_modified_by = "Adin.Ermie@outlook.com"
    git_modifiers        = "Adin.Ermie/nimrodkor"
    git_org              = "try-bridgecrew"
    git_repo             = "terragoat"
    yor_trace            = "162a7bb2-53c6-41fa-bcf9-d810f493bc2f"
  }
}

resource "azurerm_storage_account" "data" {
  name                     = "tgsa${var.environment}${random_integer.rnd_int.result}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  queue_properties {
    logging {
      delete                = false
      read                  = false
      write                 = true
      version               = "1.0"
      retention_policy_days = 10
    }
    hour_metrics {
      enabled               = true
      include_apis          = true
      version               = "1.0"
      retention_policy_days = 10
    }
    minute_metrics {
      enabled               = true
      include_apis          = true
      version               = "1.0"
      retention_policy_days = 10
    }
  }
  tags = {
    git_commit           = "e2b8c03f7bf3f42e1be4f90498c0023c6d0110e9"
    git_file             = "terraform/azure/storage.tf"
    git_last_modified_at = "2020-09-02 23:24:06"
    git_last_modified_by = "mikeurbanski1@users.noreply.github.com"
    git_modifiers        = "mikeurbanski1"
    git_org              = "try-bridgecrew"
    git_repo             = "terragoat"
    yor_trace            = "2b9bff69-ac76-45b9-8902-4204052c8695"
  }
}

resource "azurerm_storage_account_network_rules" "test" {
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_name = azurerm_storage_account.example.name

  default_action = "Deny"
  ip_rules       = ["127.0.0.1"]
  bypass         = ["Metrics"]
}
