terraform {
  backend "azurerm" {
    resource_group_name  = "shared-rg"
    storage_account_name = "cpiazza01shared"
    container_name       = "cpiazza01-tf-state"
    key                  = "adbx-workspace.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.45.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.4.0"
    }
  }
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
}

provider "azuread" {}