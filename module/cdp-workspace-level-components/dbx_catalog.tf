resource "databricks_catalog" "cdp_catalog" {
  name         = "cdp_${lower(var.env)}"
  storage_root = format("abfss://%s@%s.dfs.core.windows.net", azurerm_storage_container.cdp_catalog_storage_root.name, azurerm_storage_account.cdp_catalog_root_storage_account.name)

}