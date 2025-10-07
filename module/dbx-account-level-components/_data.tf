data "terraform_remote_state" "azurerm_components" {
  backend = "azurerm"
  config = {
    resource_group_name  = "azure-databricks-rg"
    storage_account_name = "cpiazza01dbxtfstate"
    container_name       = "tfstate"               
    key                  = "adbx-workspace.tfstate"
  }
}

data "databricks_metastore" "eastus" {
  region = "eastus"
}

data "azuread_groups" "databricks_groups" {
  display_name_prefix = "DATABRICKS_"
}

output "databricks_groups" {
  value = data.azuread_groups.databricks_groups
}