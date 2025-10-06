terraform {
  backend "azurerm" {
    resource_group_name  = "azure-databricks-rg"
    storage_account_name = "cpiazza01dbxtfstate"
    container_name       = "tfstate"
    key                  = "dbx-account-level-components.tfstate"
  }
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.91"
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