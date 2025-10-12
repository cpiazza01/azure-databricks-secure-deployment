terraform {
  backend "azurerm" {}
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

# provider "databricks" {
#   alias = "dbx_workspace"
#   host  = local.workspace_url
# }

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
}