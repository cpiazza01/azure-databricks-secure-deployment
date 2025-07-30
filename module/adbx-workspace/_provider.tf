terraform {
  backend "azurerm" {
    resource_group_name  = "azure-databricks-rg"
    storage_account_name = "cpiazza01shared"
    container_name       = "cpiazza01-tf-state"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.37.0"
    }
  }
}

provider "azurerm" {
  features {}
}