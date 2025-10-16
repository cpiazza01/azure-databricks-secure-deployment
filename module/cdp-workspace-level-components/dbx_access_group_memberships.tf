# Functions group membership - all entra groups
resource "databricks_group_member" "cdp_functions_group_membership_all_entra" {
  for_each  = local.cdp_entra_groups
  group_id  = local.cdp_functions_group.id
  member_id = each.value.id
}

# Bronze group membership - Platform ingestion team
resource "databricks_group_member" "cdp_bronze_rw_membership_platform_ingestion_team" {
  count     = var.env == "dev" ? 1 : 0
  group_id  = local.cdp_bronze_rw_group.id
  member_id = local.platform_ingestion_group.id
}
resource "databricks_group_member" "cdp_bronze_ro_membership_platform_ingestion_team" {
  group_id  = local.cdp_bronze_ro_group.id
  member_id = local.platform_ingestion_group.id
}
resource "databricks_group_member" "cdp_bronze_rw_membership_platform_ingestion_team_rw_sp" {
  group_id  = local.cdp_bronze_rw_group.id
  member_id = local.platform_ingestion_sp_rw.id
}
resource "databricks_group_member" "cdp_bronze_ro_membership_platform_ingestion_team_ro_sp" {
  group_id  = local.cdp_bronze_ro_group.id
  member_id = local.platform_ingestion_sp_rO.id
}

# Silver group membership - Platform ingestion team
resource "databricks_group_member" "cdp_silver_rw_membership_platform_ingestion_team" {
  count     = var.env == "dev" ? 1 : 0
  group_id  = local.cdp_silver_rw_group.id
  member_id = local.platform_ingestion_group.id
}
resource "databricks_group_member" "cdp_silver_ro_membership_platform_ingestion_team" {
  group_id  = local.cdp_silver_ro_group.id
  member_id = local.platform_ingestion_group.id
}
resource "databricks_group_member" "cdp_silver_rw_membership_platform_ingestion_team_rw_sp" {
  group_id  = local.cdp_silver_rw_group.id
  member_id = local.platform_ingestion_sp_rw.id
}
resource "databricks_group_member" "cdp_silver_ro_membership_platform_ingestion_team_ro_sp" {
  group_id  = local.cdp_silver_ro_group.id
  member_id = local.platform_ingestion_sp_rO.id
}

# Silver group membership - Platform conformed team
resource "databricks_group_member" "cdp_silver_rw_membership_platform_conformed_team" {
  count     = var.env == "dev" ? 1 : 0
  group_id  = local.cdp_silver_rw_group.id
  member_id = local.platform_conformed_group.id
}
resource "databricks_group_member" "cdp_silver_ro_membership_platform_conformed_team" {
  group_id  = local.cdp_silver_ro_group.id
  member_id = local.platform_conformed_group.id
}
resource "databricks_group_member" "cdp_silver_rw_membership_platform_conformed_team_rw_sp" {
  group_id  = local.cdp_silver_rw_group.id
  member_id = local.platform_conformed_sp_rw.id
}
resource "databricks_group_member" "cdp_silver_ro_membership_platform_conformed_team_ro_sp" {
  group_id  = local.cdp_silver_ro_group.id
  member_id = local.platform_conformed_sp_rO.id
}

# Gold group membership - Platform conformed team
resource "databricks_group_member" "cdp_gold_rw_membership_platform_conformed_team" {
  count     = var.env == "dev" ? 1 : 0
  group_id  = local.cdp_gold_rw_group.id
  member_id = local.platform_conformed_group.id
}
resource "databricks_group_member" "cdp_gold_ro_membership_platform_conformed_team" {
  group_id  = local.cdp_gold_ro_group.id
  member_id = local.platform_conformed_group.id
}
resource "databricks_group_member" "cdp_gold_rw_membership_platform_conformed_team_rw_sp" {
  group_id  = local.cdp_gold_rw_group.id
  member_id = local.platform_conformed_sp_rw.id
}
resource "databricks_group_member" "cdp_gold_ro_membership_platform_conformed_team_ro_sp" {
  group_id  = local.cdp_gold_ro_group.id
  member_id = local.platform_conformed_sp_rO.id
}

# Staging inbound group membership - Platform ingestion team
resource "databricks_group_member" "cdp_staging_inbound_membership_platform_ingestion_team" {
  count     = var.env == "dev" ? 1 : 0
  group_id  = local.cdp_staging_inbound_group.id
  member_id = local.platform_ingestion_group.id
}
resource "databricks_group_member" "cdp_staging_inbound_membership_platform_ingestion_team_rw_sp" {
  group_id  = local.cdp_staging_inbound_group.id
  member_id = local.platform_ingestion_sp_rw.id
}