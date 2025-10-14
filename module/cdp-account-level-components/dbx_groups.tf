resource "databricks_group" "catalog_users" {
  display_name = "CDP_CATALOG_USERS_${upper(var.env)}"
}
resource "databricks_entitlements" "catalog_users_entitlements" {
  provider              = databricks.dbx_workspace
  depends_on            = [databricks_mws_permission_assignment.account_admin]
  group_id              = databricks_group.catalog_users.id
  databricks_sql_access = true
  workspace_access      = true
}

resource "databricks_group" "entra_groups" {
  for_each     = data.azuread_group.databricks_groups
  display_name = each.value.display_name
  external_id  = each.value.object_id
}
# resource "databricks_group_member" "catalog_users_entra_groups" {
#   for_each  = databricks_group.entra_groups
#   group_id  = databricks_group.catalog_users.id
#   member_id = each.value.id
# }

# Bronze layer Access Groups
resource "databricks_group" "bronze_rw" {
  display_name = "CDP_BRONZE_RW_${upper(var.env)}"
}
resource "databricks_group" "bronze_ro" {
  display_name = "CDP_BRONZE_RO_${upper(var.env)}"
}
resource "databricks_group_member" "catalog_users_bronze_rw" {
  group_id  = databricks_group.catalog_users.id
  member_id = databricks_group.bronze_rw.id
}
resource "databricks_group_member" "catalog_users_bronze_ro" {
  group_id  = databricks_group.catalog_users.id
  member_id = databricks_group.bronze_ro.id
}

# Silver layer Access Groups
resource "databricks_group" "silver_rw" {
  display_name = "CDP_SILVER_RW_${upper(var.env)}"
}
resource "databricks_group" "silver_ro" {
  display_name = "CDP_SILVER_RO_${upper(var.env)}"
}
resource "databricks_group_member" "catalog_users_silver_rw" {
  group_id  = databricks_group.catalog_users.id
  member_id = databricks_group.silver_rw.id
}
resource "databricks_group_member" "catalog_users_silver_ro" {
  group_id  = databricks_group.catalog_users.id
  member_id = databricks_group.silver_ro.id
}

# Gold layer Access Groups
resource "databricks_group" "gold_rw" {
  display_name = "CDP_GOLD_RW_${upper(var.env)}"
}
resource "databricks_group" "gold_ro" {
  display_name = "CDP_GOLD_RO_${upper(var.env)}"
}
resource "databricks_group_member" "catalog_users_gold_rw" {
  group_id  = databricks_group.catalog_users.id
  member_id = databricks_group.gold_rw.id
}
resource "databricks_group_member" "catalog_users_gold_ro" {
  group_id  = databricks_group.catalog_users.id
  member_id = databricks_group.gold_ro.id
}

# Staging Inbound Access Groups
resource "databricks_group" "staging_inbound" {
  display_name = "CDP_STAGING_INBOUND_${upper(var.env)}"
}
resource "databricks_group_member" "catalog_users_staging_inbound" {
  group_id  = databricks_group.catalog_users.id
  member_id = databricks_group.staging_inbound.id
}

# Staging Outbound Access Groups
resource "databricks_group" "staging_outbound" {
  display_name = "CDP_STAGING_OUTBOUND_${upper(var.env)}"
}
resource "databricks_group_member" "catalog_users_staging_outbound" {
  group_id  = databricks_group.catalog_users.id
  member_id = databricks_group.staging_outbound.id
}