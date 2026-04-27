# Catalog
resource "databricks_catalog" "cdp_catalog" {
  name           = "cdp_${lower(var.env)}"
  storage_root   = databricks_external_location.cdp_catalog_root_ext_loc.url
  owner          = local.cdp_entra_group_workspace_admin.display_name
  isolation_mode = "ISOLATION_MODE_ISOLATED"
}
resource "databricks_grant" "cdp_catalog_users_rw" {
  catalog    = databricks_catalog.cdp_catalog.name
  principal  = local.cdp_catalog_users_rw_group.display_name
  privileges = var.cdp_catalog_privileges
}
resource "databricks_grant" "cdp_catalog_users_ro" {
  catalog    = databricks_catalog.cdp_catalog.name
  principal  = local.cdp_catalog_users_ro_group.display_name
  privileges = var.cdp_catalog_privileges
}

resource "databricks_schema" "cdp_bronze_schemas" {
  for_each     = { for k, v in local.cdp_entra_groups_project_teams : v.display_name => v }
  catalog_name = databricks_catalog.cdp_catalog.id
  name         = "bronze_${split("_${upper(var.env)}", split("_TEAM_", each.value.display_name)[1])[0]}"
  comment      = "Schema for holding the raw data for the project team '${each.value.display_name}'."
  storage_root = databricks_external_location.cdp_catalog_bronze_ext_loc.url
}

resource "databricks_schema" "cdp_silver_schemas" {
  for_each     = { for k, v in local.cdp_entra_groups_project_teams : v.display_name => v }
  catalog_name = databricks_catalog.cdp_catalog.id
  name         = "silver_${split("_${upper(var.env)}", split("_TEAM_", each.value.display_name)[1])[0]}"
  comment      = "Schema for holding the refined data for the project team '${each.value.display_name}'."
  storage_root = databricks_external_location.cdp_catalog_silver_ext_loc.url
}