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
  }
}

provider "databricks" {}