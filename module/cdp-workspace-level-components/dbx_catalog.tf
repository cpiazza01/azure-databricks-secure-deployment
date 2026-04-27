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
  for_each     = { for k, v in local.schema_grant_project_team_mappings : v.project_name => v }
  catalog_name = databricks_catalog.cdp_catalog.id
  name         = "bronze_${each.value.project_name}"
  comment      = "Schema for holding the raw data for the for the following data source/project team: ${each.value.project_name}"
  storage_root = databricks_external_location.cdp_catalog_bronze_ext_loc.url
}
resource "databricks_grant" "cdp_bronze_schemas_groups" {
  for_each   = { for k, v in local.schema_grant_project_team_mappings : v.project_name => v }
  schema     = "${databricks_catalog.cdp_catalog.name}.bronze_${each.value.project_name}"
  principal  = each.value.group_display_name
  privileges = var.env == "dev" ? var.cdp_rw_privileges_table_schemas : var.cdp_ro_privileges_table_schemas
  depends_on = [databricks_schema.cdp_bronze_schemas]
}
resource "databricks_grant" "cdp_bronze_schemas_sps_rw" {
  for_each   = { for k, v in local.schema_grant_project_team_mappings : v.project_name => v }
  schema     = "${databricks_catalog.cdp_catalog.name}.bronze_${each.value.project_name}"
  principal  = each.value.sp_rw_app_id
  privileges = var.cdp_rw_privileges_table_schemas
  depends_on = [databricks_schema.cdp_bronze_schemas]
}
resource "databricks_grant" "cdp_bronze_schemas_sps_ro" {
  for_each   = { for k, v in local.schema_grant_project_team_mappings : v.project_name => v }
  schema     = "${databricks_catalog.cdp_catalog.name}.bronze_${each.value.project_name}"
  principal  = each.value.sp_ro_app_id
  privileges = var.cdp_ro_privileges_table_schemas
  depends_on = [databricks_schema.cdp_bronze_schemas]
}

resource "databricks_schema" "cdp_silver_schemas" {
  for_each     = { for k, v in local.schema_grant_project_team_mappings : v.project_name => v }
  catalog_name = databricks_catalog.cdp_catalog.id
  name         = "silver_${each.value.project_name}"
  comment      = "Schema for holding the silver data for the for the following data source/project team: ${each.value.project_name}"
  storage_root = databricks_external_location.cdp_catalog_silver_ext_loc.url
}
resource "databricks_grant" "cdp_silver_schemas_groups" {
  for_each   = { for k, v in local.schema_grant_project_team_mappings : v.project_name => v }
  schema     = "${databricks_catalog.cdp_catalog.name}.silver_${each.value.project_name}"
  principal  = each.value.group_display_name
  privileges = var.env == "dev" ? var.cdp_rw_privileges_table_schemas : var.cdp_ro_privileges_table_schemas
  depends_on = [databricks_schema.cdp_silver_schemas]
}
resource "databricks_grant" "cdp_silver_schemas_sps_rw" {
  for_each   = { for k, v in local.schema_grant_project_team_mappings : v.project_name => v }
  schema     = "${databricks_catalog.cdp_catalog.name}.silver_${each.value.project_name}"
  principal  = each.value.sp_rw_app_id
  privileges = var.cdp_rw_privileges_table_schemas
  depends_on = [databricks_schema.cdp_silver_schemas]
}
resource "databricks_grant" "cdp_silver_schemas_sps_ro" {
  for_each   = { for k, v in local.schema_grant_project_team_mappings : v.project_name => v }
  schema     = "${databricks_catalog.cdp_catalog.name}.silver_${each.value.project_name}"
  principal  = each.value.sp_ro_app_id
  privileges = var.cdp_ro_privileges_table_schemas
  depends_on = [databricks_schema.cdp_silver_schemas]
}

resource "databricks_schema" "cdp_gold_datamart_schemas" {
  for_each     = var.cdp_gold_datamart_schemas
  catalog_name = databricks_catalog.cdp_catalog.id
  name         = "gold_datamart_${each.value}"
  comment      = "Schema for holding the curated datamart (star/dim tables) data for the ${each.value} domain"
  storage_root = databricks_external_location.cdp_catalog_gold_ext_loc.url
}

resource "databricks_schema" "cdp_gold_reporting_schema" {
  catalog_name = databricks_catalog.cdp_catalog.id
  name         = "gold_reporting"
  comment      = "Schema for holding semantic/reporting data products"
  storage_root = databricks_external_location.cdp_catalog_gold_ext_loc.url
}