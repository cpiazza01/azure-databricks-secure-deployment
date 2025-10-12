resource "databricks_catalog" "cdp_catalog" {
  depends_on = [databricks_mws_permission_assignment.account_admin]
  name       = "cdp_${lower(var.env)}"
}