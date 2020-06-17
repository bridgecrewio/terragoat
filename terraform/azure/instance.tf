resource random_string "password" {
  length      = 16
  special     = false
  min_lower   = 1
  min_numeric = 1
  min_upper   = 1
}

resource azurerm_linux_virtual_machine "linux_machine" {
  admin_username                  = "terragoat-${var.environment}"
  admin_password                  = random_string.password.result
  location                        = var.location
  name                            = "terragoat-linux-${var.environment}"
  network_interface_ids           = [azurerm_network_interface.example.id]
  resource_group_name             = azurerm_resource_group.example.name
  size                            = "Standard_F2"
  disable_password_authentication = false
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

resource azurerm_windows_virtual_machine "windows_machine" {
  admin_password        = random_string.password.result
  admin_username        = "tg-${var.environment}"
  location              = var.location
  name                  = "terragoat-windows-machine-${var.environment}"
  network_interface_ids = [azurerm_network_interface.example.id]
  resource_group_name   = azurerm_resource_group.example.name
  size                  = "Standard_F2"
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}