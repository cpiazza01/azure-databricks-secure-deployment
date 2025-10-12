resource "databricks_catalog" "cdp_catalog" {
  name = "cdp_${lower(var.env)}"
}