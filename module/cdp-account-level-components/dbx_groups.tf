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
resource "databricks_access_control_rule_set" "ws_admin_bronze_rw" {
  name = "accounts/${var.databricks_account_id}/groups/${databricks_group.bronze_rw.id}/ruleSets/default"
  grant_rules {
    principals = [local.workspace_admin_group.acl_principal_id]
    role       = "roles/group.manager"
  }
}
resource "databricks_access_control_rule_set" "ws_admin_bronze_ro" {
  name = "accounts/${var.databricks_account_id}/groups/${databricks_group.bronze_ro.id}/ruleSets/default"
  grant_rules {
    principals = [local.workspace_admin_group.acl_principal_id]
    role       = "roles/group.manager"
  }
}

# Silver layer Access Groups
resource "databricks_group" "silver_rw" {
  display_name = "CDP_SILVER_RW_${upper(var.env)}"
}
resource "databricks_group" "silver_ro" {
  display_name = "CDP_SILVER_RO_${upper(var.env)}"
}
resource "databricks_access_control_rule_set" "ws_admin_silver_rw" {
  name = "accounts/${var.databricks_account_id}/groups/${databricks_group.silver_rw.id}/ruleSets/default"
  grant_rules {
    principals = [local.workspace_admin_group.acl_principal_id]
    role       = "roles/group.manager"
  }
}
resource "databricks_access_control_rule_set" "ws_admin_silver_ro" {
  name = "accounts/${var.databricks_account_id}/groups/${databricks_group.silver_ro.id}/ruleSets/default"
  grant_rules {
    principals = [local.workspace_admin_group.acl_principal_id]
    role       = "roles/group.manager"
  }
}

# Gold layer Access Groups
resource "databricks_group" "gold_rw" {
  display_name = "CDP_GOLD_RW_${upper(var.env)}"
}
resource "databricks_group" "gold_ro" {
  display_name = "CDP_GOLD_RO_${upper(var.env)}"
}
resource "databricks_access_control_rule_set" "ws_admin_gold_rw" {
  name = "accounts/${var.databricks_account_id}/groups/${databricks_group.gold_rw.id}/ruleSets/default"
  grant_rules {
    principals = [local.workspace_admin_group.acl_principal_id]
    role       = "roles/group.manager"
  }
}
resource "databricks_access_control_rule_set" "ws_admin_gold_ro" {
  name = "accounts/${var.databricks_account_id}/groups/${databricks_group.gold_ro.id}/ruleSets/default"
  grant_rules {
    principals = [local.workspace_admin_group.acl_principal_id]
    role       = "roles/group.manager"
  }
}

# Staging Inbound Access Groups
resource "databricks_group" "staging_inbound" {
  display_name = "CDP_STAGING_INBOUND_${upper(var.env)}"
}
resource "databricks_access_control_rule_set" "ws_admin_staging_inbound" {
  name = "accounts/${var.databricks_account_id}/groups/${databricks_group.staging_inbound.id}/ruleSets/default"
  grant_rules {
    principals = [local.workspace_admin_group.acl_principal_id]
    role       = "roles/group.manager"
  }
}


# Staging Outbound Access Groups
resource "databricks_group" "staging_outbound" {
  display_name = "CDP_STAGING_OUTBOUND_${upper(var.env)}"
}
resource "databricks_access_control_rule_set" "ws_admin_staging_outbound" {
  name = "accounts/${var.databricks_account_id}/groups/${databricks_group.staging_outbound.id}/ruleSets/default"
  grant_rules {
    principals = [local.workspace_admin_group.acl_principal_id]
    role       = "roles/group.manager"
  }
}

# Functions Access Groups
resource "databricks_group" "functions" {
  display_name = "CDP_FUNCTIONS_${upper(var.env)}"
}
resource "databricks_access_control_rule_set" "ws_admin_functions" {
  name = "accounts/${var.databricks_account_id}/groups/${databricks_group.functions.id}/ruleSets/default"
  grant_rules {
    principals = [local.workspace_admin_group.acl_principal_id]
    role       = "roles/group.manager"
  }
}