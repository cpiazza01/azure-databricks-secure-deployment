# Catalog
resource "databricks_catalog" "cdp_catalog" {
  name           = "cdp_${lower(var.env)}"
  storage_root   = databricks_external_location.cdp_catalog_root_ext_loc.url
  owner          = local.workspace_admin_group.display_name
  isolation_mode = "ISOLATION_MODE_ISOLATED"
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

# Functions
resource "databricks_schema" "cdp_functions_schema" {
  catalog_name = databricks_catalog.cdp_catalog.id
  name         = "functions"
  comment      = "Schema that teams can use to create functions if needed."
}
resource "databricks_grant" "functions_schema_ro" {
  schema     = databricks_schema.cdp_functions_schema.id
  principal  = local.cdp_functions_ro_group.display_name
  privileges = var.cdp_privileges_functions_schema_ro
}
resource "databricks_grant" "functions_schema_rw" {
  schema     = databricks_schema.cdp_functions_schema.id
  principal  = local.cdp_functions_rw_group.display_name
  privileges = var.cdp_privileges_functions_schema_rw
}

# Audit
resource "databricks_schema" "cdp_audit_schema" {
  catalog_name = databricks_catalog.cdp_catalog.id
  name         = "audit"
  comment      = "Schema that teams can use to for auditing/tracking purposes, such as logs or checkpoints."
}
resource "databricks_grant" "audit_schema_ro" {
  schema     = databricks_schema.cdp_audit_schema.id
  principal  = local.cdp_audit_ro_group.display_name
  privileges = var.cdp_ro_privileges_table_schemas
}
resource "databricks_grant" "audit_schema_rw" {
  schema     = databricks_schema.cdp_audit_schema.id
  principal  = local.cdp_audit_rw_group.display_name
  privileges = var.cdp_rw_privileges_table_schemas
}

# Analytics Team Work Schemas
# resource "databricks_schema" "cdp_analytics_team_work_schemas" {
#   for_each     = { for index, group in local.cdp_entra_groups : group.display_name => group  if startswith(group.display_name, "CDP_ANALYTICS_TEAM_")}
#   catalog_name = databricks_catalog.cdp_catalog.id
#   name         = lower(trimsuffix(trimprefix(group.display_name, "CDP_"), "_${upper(var.env)}"))
#   comment      = "${group.display_name} Work Schema"
# }
# resource "databricks_grant" "audit_schema_ro" {
#   schema     = databricks_schema.cdp_audit_schema.id
#   principal  = local.cdp_audit_ro_group.display_name
#   privileges = var.cdp_ro_privileges_table_schemas
# }
# resource "databricks_grant" "audit_schema_rw" {
#   schema     = databricks_schema.cdp_audit_schema.id
#   principal  = local.cdp_audit_rw_group.display_name
#   privileges = var.cdp_rw_privileges_table_schemas
# }

# Cluster logs volume
resource "databricks_volume" "cluster_logs_volumes" {
  for_each     = { for index, group in local.cdp_entra_groups : group.display_name => group }
  name         = "cluster_logs_${lower(each.value.display_name)}"
  catalog_name = databricks_catalog.cdp_catalog.name
  schema_name  = databricks_schema.cdp_audit_schema.name
  volume_type  = "MANAGED"
  comment      = "Cluster logs volume provisioned for group ${each.value.display_name}"
}
resource "databricks_grant" "cluster_logs_grants" {
  for_each   = databricks_volume.cluster_logs_volumes
  volume     = each.value.id
  principal  = upper(split("cluster_logs_", each.value.name)[1])
  privileges = ["READ_VOLUME", "WRITE_VOLUME"]
}