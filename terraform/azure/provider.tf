provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}

data "azurerm_client_config" "current" {}
//
//terraform {
//  backend "azurerm" {
//    container_name = "tfstate"
//  }
//}
