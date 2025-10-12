resource "time_sleep" "wait_until_access" {
  create_duration = "10s"
  depends_on = [
    azurerm_role_assignment.storage_account_access_catalog_root,
    azurerm_role_assignment.storage_account_access_stage
  ]
}

resource "databricks_external_location" "cdp_catalog_root_ext_loc" {
  name            = "cdp_catalog_stage_ext_loc_${lower(var.env)}"
  url             = format("abfss://%s@%s.dfs.core.windows.net", azurerm_storage_container.cdp_catalog_storage_root.name, azurerm_storage_account.cdp_catalog_root_storage_account.name)
  credential_name = local.cdp_storage_credential.id
  skip_validation = true
  depends_on      = [time_sleep.wait_until_access]
}

resource "databricks_external_location" "cdp_catalog_stage_ext_loc" {
  name            = "cdp_catalog_stage_ext_loc_${lower(var.env)}"
  url             = format("abfss://%s@%s.dfs.core.windows.net", azurerm_storage_container.cdp_catalog_storage_stage.name, azurerm_storage_account.cdp_stage_storage_account.name)
  credential_name = local.cdp_storage_credential.id
  skip_validation = true
  depends_on      = [time_sleep.wait_until_access]
}