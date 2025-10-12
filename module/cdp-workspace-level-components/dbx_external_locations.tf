resource "databricks_external_location" "cdp_catalog_stage_ext_loc" {
  name            = "cdp_catalog_stage_ext_loc_${lower(var.env)}"
  url             = format("abfss://%s@%s.dfs.core.windows.net", azurerm_storage_container.cdp_catalog_storage_stage.name, azurerm_storage_account.cdp_stage_storage_account.name)
  credential_name = databricks_storage_credential.cdp_storage_credential.id
}