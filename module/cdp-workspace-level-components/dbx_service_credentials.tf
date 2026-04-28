resource "azurerm_databricks_access_connector" "cdp_service_credential_access_connectors" {
  for_each            = { for k, v in var.service_credential_configs : v.project_name => v }
  name                = "cdp_access_connector_for_service_credential_${each.value.project_name}_${lower(var.env)}"
  resource_group_name = var.resource_group_name
  location            = var.location

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "cdp_service_credential_access_connector_role_assignments" {
  for_each             = { for k, v in local.access_connector_service_credential_config_mappings : v.project_name => v }
  scope                = each.value.resource_id
  role_definition_name = each.value.role_name
  principal_id         = each.value.access_connector_principal_id
}

resource "databricks_credential" "cdp_service_credentials" {
  for_each       = { for k, v in local.access_connector_service_credential_config_mappings : v.project_name => v }
  name           = "cdp_service_credential_${each.value.project_name}_${lower(var.env)}"
  purpose        = "SERVICE"
  isolation_mode = "ISOLATION_MODE_ISOLATED"

  azure_managed_identity {
    access_connector_id = each.value.access_connector_id
  }
}

resource "databricks_grants" "cdp_service_credentials_grants_groups" {
  for_each   = { for k, v in local.service_credential_to_group_mappings : v.project_name => v if var.env == "dev" }
  credential = each.value.service_credential_id

  grant {
    principal  = each.value.group_display_name
    privileges = ["ACCESS"]
  }
}
resource "databricks_grants" "cdp_service_credentials_grants_rw_sps" {
  for_each   = { for k, v in local.service_credential_to_group_mappings : v.project_name => v if var.env == "dev" }
  credential = each.value.service_credential_id

  grant {
    principal  = each.value.sp_rw_app_id
    privileges = ["ACCESS"]
  }
}
resource "databricks_grants" "cdp_service_credentials_grants_ro_sps" {
  for_each   = { for k, v in local.service_credential_to_group_mappings : v.project_name => v if var.env == "dev" }
  credential = each.value.service_credential_id

  grant {
    principal  = each.value.sp_ro_app_id
    privileges = ["ACCESS"]
  }
}