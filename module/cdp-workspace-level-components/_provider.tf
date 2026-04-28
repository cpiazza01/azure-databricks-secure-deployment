terraform {
  backend "azurerm" {}
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.113"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.43.0"
    }
  }
}

provider "databricks" {
  host      = local.workspace_url
  client_id = local.cdp_workspace_admin_sp.application_id
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
}