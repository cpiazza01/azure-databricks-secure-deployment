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

provider "databricks" {}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
}