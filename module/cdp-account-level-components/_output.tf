output "cdp_access_connector" {
  value = azurerm_databricks_access_connector.cdp_access_connector
}

output "cdp_storage_credential" {
  value = databricks_storage_credential.cdp_storage_credential
}

# Groups
output "cdp_catalog_users_rw_group" {
  value = databricks_group.catalog_users_rw
}
output "cdp_catalog_users_ro_group" {
  value = databricks_group.catalog_users_ro
}
output "cdp_entra_group_workspace_admin" {
  value = [for group in databricks_group.entra_group_workspace_admin_team : group][0]
}
output "cdp_entra_groups_project_teams" {
  value = databricks_group.entra_groups_project_teams
}
output "cdp_entra_group_data_product_team" {
  value = databricks_group.entra_group_data_product_team
}

# Service Principals
output "cdp_project_teams_rw_sps" {
  value = databricks_service_principal.project_teams_rw_sps
}
output "cdp_project_teams_ro_sps" {
  value = databricks_service_principal.project_teams_ro_sps
}
output "cdp_data_product_team_rw_sps" {
  value = databricks_service_principal.data_product_team_rw_sp
}
output "cdp_data_product_team_ro_sps" {
  value = databricks_service_principal.data_product_team_ro_sp
}
output "cdp_workspace_admin_sp" {
  value = databricks_service_principal.workspace_admin_sp
}