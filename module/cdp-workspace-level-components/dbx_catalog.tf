# Catalog
resource "databricks_catalog" "cdp_catalog" {
  name         = "cdp_${lower(var.env)}"
  storage_root = databricks_external_location.cdp_catalog_root_ext_loc.url
  owner        = local.workspace_admin_group.display_name
}
resource "databricks_grant" "cdp_catalog_users" {
  catalog = databricks_catalog.cdp_catalog.name

  principal  = local.cdp_catalog_users_group.display_name
  privileges = var.cdp_catalog_privileges
}

# Bronze
resource "databricks_schema" "cdp_bronze_schemas" {
  for_each     = toset(var.cdp_bronze_and_silver_schemas)
  catalog_name = databricks_catalog.cdp_catalog.id
  name         = "bronze_${each.value}"
  comment      = "Schema for holding the raw data ingested from the '${each.value}' data source."
  storage_root = databricks_external_location.cdp_catalog_bronze_ext_loc.url
}
resource "databricks_grant" "bronze_schemas_ro" {
  for_each   = databricks_schema.cdp_bronze_schemas
  schema     = each.value.id
  principal  = local.cdp_bronze_ro_group.display_name
  privileges = var.cdp_ro_privileges_table_schemas
}
resource "databricks_grant" "bronze_schemas_rw" {
  for_each   = databricks_schema.cdp_bronze_schemas
  schema     = each.value.id
  principal  = local.cdp_bronze_rw_group.display_name
  privileges = var.cdp_rw_privileges_table_schemas
}

# Silver
resource "databricks_schema" "cdp_silver_schemas" {
  for_each     = toset(var.cdp_bronze_and_silver_schemas)
  catalog_name = databricks_catalog.cdp_catalog.id
  name         = "silver_${each.value}"
  comment      = "Schema for holding the cleaned/refined data ingested from the '${each.value}' data source."
  storage_root = databricks_external_location.cdp_catalog_silver_ext_loc.url
}
resource "databricks_grant" "silver_schemas_ro" {
  for_each   = databricks_schema.cdp_silver_schemas
  schema     = each.value.id
  principal  = local.cdp_silver_ro_group.display_name
  privileges = var.cdp_ro_privileges_table_schemas
}
resource "databricks_grant" "silver_schemas_rw" {
  for_each   = databricks_schema.cdp_silver_schemas
  schema     = each.value.id
  principal  = local.cdp_silver_rw_group.display_name
  privileges = var.cdp_rw_privileges_table_schemas
}

# Gold
resource "databricks_schema" "cdp_gold_schemas" {
  for_each     = toset(var.cdp_gold_schemas)
  catalog_name = databricks_catalog.cdp_catalog.id
  name         = "gold_${each.value}"
  comment      = "Schema for holding the confirmed data for the '${each.value}' business domain."
  storage_root = databricks_external_location.cdp_catalog_gold_ext_loc.url
}
resource "databricks_grant" "gold_schemas_ro" {
  for_each   = databricks_schema.cdp_gold_schemas
  schema     = each.value.id
  principal  = local.cdp_gold_ro_group.display_name
  privileges = var.cdp_ro_privileges_table_schemas
}
resource "databricks_grant" "gold_schemas_rw" {
  for_each   = databricks_schema.cdp_gold_schemas
  schema     = each.value.id
  principal  = local.cdp_gold_rw_group.display_name
  privileges = var.cdp_rw_privileges_table_schemas
}

resource "databricks_schema" "cdp_functions_schema" {
  catalog_name = databricks_catalog.cdp_catalog.id
  name         = "functions"
  comment      = "Schema that teams can use to create functions if needed."
}
resource "databricks_grant" "functions_schema" {
  schema     = databricks_schema.cdp_functions_schema.id
  principal  = local.cdp_functions_group.display_name
  privileges = var.cdp_privileges_functions_schema
}