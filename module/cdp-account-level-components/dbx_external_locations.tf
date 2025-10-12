# resource "databricks_external_location" "cdp_catalog" {
#   name = "cdp_catalog_${lower(var.env)}"
#   url = format("abfss://%s@%s.dfs.core.windows.net",
#     azurerm_storage_container.ext_storage.name,
#   azurerm_storage_account.ext_storage.name)
#   credential_name = databricks_storage_credential.external.id
#   comment         = "Managed by TF"
#   depends_on = [
#     databricks_metastore_assignment.this
#   ]
# }