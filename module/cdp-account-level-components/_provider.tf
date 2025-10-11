terraform {
  backend "azurerm" {}
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.85"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.43.0"
    }
  }
}

provider "databricks" {
  host       = "https://accounts.azuredatabricks.net"
  account_id = "946e76c0-2fb6-426d-aa32-e75c629076f0"
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
}