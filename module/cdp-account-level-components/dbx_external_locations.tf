resource "databricks_external_location" "cdp_catalog" {
  name = "cdp_catalog_${lower(var.env)}"
  url = format("abfss://%s@%s.dfs.core.windows.net",
    data.azurerm_storage_container.cdp_catalog.name,
  data.azurerm_storage_account.cdpdatabrick.name)
  credential_name = databricks_storage_credential.cdp_storage_credential.id
}