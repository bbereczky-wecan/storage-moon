# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "CloudSummit-01"
  location = "ukw"
}

resource "azurerm_subscription" "storage" {
  alias             = "storagesub"
  subscription_name = "My Storage Subscription"
  subscription_id   = "71818d77-4e18-47c8-8c36-b7af11e60bde"
}

resource "azurerm_storage_account" "example" {
  name                     = "bicep_moon_storage_111_${azurerm_subscription.storage.subscription_id}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
