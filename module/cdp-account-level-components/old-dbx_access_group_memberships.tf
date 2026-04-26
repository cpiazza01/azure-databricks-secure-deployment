# # Functions schema
# resource "databricks_group_member" "cdp_functions_group_membership_all_entra" {
#   for_each  = databricks_group.entra_groups
#   group_id  = var.env == "dev" ? databricks_group.functions_rw.id : databricks_group.functions_ro.id
#   member_id = each.value.id
# }
# resource "databricks_group_member" "cdp_functions_group_membership_all_rw_sps" {
#   for_each  = databricks_service_principal.rw
#   group_id  = databricks_group.functions_rw.id
#   member_id = each.value.id
# }
# resource "databricks_group_member" "cdp_functions_group_membership_all_ro_sps" {
#   for_each  = databricks_service_principal.ro
#   group_id  = databricks_group.functions_ro.id
#   member_id = each.value.id
# }

# # Audit schema
# resource "databricks_group_member" "cdp_audit_group_membership_all_entra" {
#   for_each  = databricks_group.entra_groups
#   group_id  = var.env == "dev" ? databricks_group.audit_rw.id : databricks_group.audit_ro.id
#   member_id = each.value.id
# }
# resource "databricks_group_member" "cdp_audit_group_membership_all_rw_sps" {
#   for_each  = databricks_service_principal.rw
#   group_id  = databricks_group.audit_rw.id
#   member_id = each.value.id
# }
# resource "databricks_group_member" "cdp_audit_group_membership_all_ro_sps" {
#   for_each  = databricks_service_principal.ro
#   group_id  = databricks_group.audit_ro.id
#   member_id = each.value.id
# }

# # Bronze group membership - Platform ingestion team
# resource "databricks_group_member" "cdp_bronze_rw_membership_platform_ingestion_team" {
#   count     = var.env == "dev" ? 1 : 0
#   group_id  = databricks_group.bronze_rw.id
#   member_id = local.platform_ingestion_group.id
# }
# resource "databricks_group_member" "cdp_bronze_ro_membership_platform_ingestion_team" {
#   group_id  = databricks_group.bronze_ro.id
#   member_id = local.platform_ingestion_group.id
# }
# resource "databricks_group_member" "cdp_bronze_rw_membership_platform_ingestion_team_rw_sp" {
#   group_id  = databricks_group.bronze_rw.id
#   member_id = local.platform_ingestion_sp_rw.id
# }
# resource "databricks_group_member" "cdp_bronze_ro_membership_platform_ingestion_team_ro_sp" {
#   group_id  = databricks_group.bronze_ro.id
#   member_id = local.platform_ingestion_sp_ro.id
# }

# # Silver group membership - Platform ingestion team
# resource "databricks_group_member" "cdp_silver_rw_membership_platform_ingestion_team" {
#   count     = var.env == "dev" ? 1 : 0
#   group_id  = databricks_group.silver_rw.id
#   member_id = local.platform_ingestion_group.id
# }
# resource "databricks_group_member" "cdp_silver_ro_membership_platform_ingestion_team" {
#   group_id  = databricks_group.silver_ro.id
#   member_id = local.platform_ingestion_group.id
# }
# resource "databricks_group_member" "cdp_silver_rw_membership_platform_ingestion_team_rw_sp" {
#   group_id  = databricks_group.silver_rw.id
#   member_id = local.platform_ingestion_sp_rw.id
# }
# resource "databricks_group_member" "cdp_silver_ro_membership_platform_ingestion_team_ro_sp" {
#   group_id  = databricks_group.silver_ro.id
#   member_id = local.platform_ingestion_sp_ro.id
# }

# # Silver group membership - Platform conformed team
# resource "databricks_group_member" "cdp_silver_rw_membership_platform_conformed_team" {
#   count     = var.env == "dev" ? 1 : 0
#   group_id  = databricks_group.silver_rw.id
#   member_id = local.platform_conformed_group.id
# }
# resource "databricks_group_member" "cdp_silver_ro_membership_platform_conformed_team" {
#   group_id  = databricks_group.silver_ro.id
#   member_id = local.platform_conformed_group.id
# }
# resource "databricks_group_member" "cdp_silver_rw_membership_platform_conformed_team_rw_sp" {
#   group_id  = databricks_group.silver_rw.id
#   member_id = local.platform_conformed_sp_rw.id
# }
# resource "databricks_group_member" "cdp_silver_ro_membership_platform_conformed_team_ro_sp" {
#   group_id  = databricks_group.silver_ro.id
#   member_id = local.platform_conformed_sp_ro.id
# }

# # Gold group membership - Platform conformed team
# resource "databricks_group_member" "cdp_gold_rw_membership_platform_conformed_team" {
#   count     = var.env == "dev" ? 1 : 0
#   group_id  = databricks_group.gold_rw.id
#   member_id = local.platform_conformed_group.id
# }
# resource "databricks_group_member" "cdp_gold_ro_membership_platform_conformed_team" {
#   group_id  = databricks_group.gold_ro.id
#   member_id = local.platform_conformed_group.id
# }
# resource "databricks_group_member" "cdp_gold_rw_membership_platform_conformed_team_rw_sp" {
#   group_id  = databricks_group.gold_rw.id
#   member_id = local.platform_conformed_sp_rw.id
# }
# resource "databricks_group_member" "cdp_gold_ro_membership_platform_conformed_team_ro_sp" {
#   group_id  = databricks_group.gold_ro.id
#   member_id = local.platform_conformed_sp_ro.id
# }

# # Staging inbound group membership - Platform ingestion team
# resource "databricks_group_member" "cdp_staging_inbound_membership_platform_ingestion_team" {
#   count     = var.env == "dev" ? 1 : 0
#   group_id  = databricks_group.staging_inbound.id
#   member_id = local.platform_ingestion_group.id
# }
# resource "databricks_group_member" "cdp_staging_inbound_membership_platform_ingestion_team_rw_sp" {
#   group_id  = databricks_group.staging_inbound.id
#   member_id = local.platform_ingestion_sp_rw.id
# }

# # Staging inbound group membership - App teams
# resource "databricks_group_member" "cdp_staging_inbound_membership_app_teams_dev" {
#   for_each  = { for group in local.app_team_groups : group.display_name => group if var.env == "dev" }
#   group_id  = databricks_group.staging_inbound.id
#   member_id = each.value.id
# }
# resource "databricks_group_member" "cdp_staging_inbound_membership_app_teams_rw_sp" {
#   for_each  = { for sp in local.app_team_sps_rw : sp.display_name => sp }
#   group_id  = databricks_group.staging_inbound.id
#   member_id = each.value.id
# }

# # Staging outbound group membership - App teams
# resource "databricks_group_member" "cdp_staging_outbound_membership_app_teams_dev" {
#   for_each  = { for group in local.app_team_groups : group.display_name => group if var.env == "dev" }
#   group_id  = databricks_group.staging_outbound.id
#   member_id = each.value.id
# }
# resource "databricks_group_member" "cdp_staging_outbound_membership_app_teams_rw_sp" {
#   for_each  = { for sp in local.app_team_sps_rw : sp.display_name => sp }
#   group_id  = databricks_group.staging_outbound.id
#   member_id = each.value.id
# }