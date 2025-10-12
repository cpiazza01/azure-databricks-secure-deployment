resource "databricks_catalog" "cdp_catalog" {
  name         = "cdp_${lower(var.env)}"
  storage_root = databricks_external_location.cdp_catalog_root_ext_loc.url
}