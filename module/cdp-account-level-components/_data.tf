# data "databricks_current_user" "me" {}

data "terraform_remote_state" "azurerm_components" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.resource_group_name
    storage_account_name = "cdpdatabricksdev"
    container_name       = "cdp-tfstate"
    key                  = "azurerm-cdp-dbx-workspace.tfstate"
  }
}

data "databricks_metastore" "eastus" {
  region = "eastus"
}

data "azuread_groups" "cdp_group_objects" {
  display_name_prefix = "CDP_"
  security_enabled    = true
}

data "azuread_group" "databricks_groups" {
  # for_each     = { for key, value in data.azuread_groups.cdp_group_objects.display_names : value => value if endswith(value, "_${upper(var.env)}")}
  for_each     = toset([for name in data.azuread_groups.cdp_group_objects.display_names : name if endswith(name, "_${upper(var.env)}")])
  display_name = each.value
}

data "azurerm_storage_account" "cdpdatabrick" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

data "databricks_service_principal" "account_admin_sp" {
  display_name = "DATABRICKS_ACCOUNT_ADMIN_SP"
}

