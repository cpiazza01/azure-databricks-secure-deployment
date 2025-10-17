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
resource "databricks_group_member" "catalog_users_entra_groups" {
  for_each  = databricks_group.entra_groups
  group_id  = databricks_group.catalog_users.id
  member_id = each.value.id
}

# Bronze layer Access Groups
resource "databricks_group" "bronze_rw" {
  display_name = "CDP_BRONZE_RW_${upper(var.env)}"
}
resource "databricks_group" "bronze_ro" {
  display_name = "CDP_BRONZE_RO_${upper(var.env)}"
}

# Silver layer Access Groups
resource "databricks_group" "silver_rw" {
  display_name = "CDP_SILVER_RW_${upper(var.env)}"
}
resource "databricks_group" "silver_ro" {
  display_name = "CDP_SILVER_RO_${upper(var.env)}"
}

# Gold layer Access Groups
resource "databricks_group" "gold_rw" {
  display_name = "CDP_GOLD_RW_${upper(var.env)}"
}
resource "databricks_group" "gold_ro" {
  display_name = "CDP_GOLD_RO_${upper(var.env)}"
}

# Staging Inbound Access Groups
resource "databricks_group" "staging_inbound" {
  display_name = "CDP_STAGING_INBOUND_${upper(var.env)}"
}

# Staging Outbound Access Groups
resource "databricks_group" "staging_outbound" {
  display_name = "CDP_STAGING_OUTBOUND_${upper(var.env)}"
}

# Functions Access Groups
resource "databricks_group" "functions" {
  display_name = "CDP_FUNCTIONS_${upper(var.env)}"
}