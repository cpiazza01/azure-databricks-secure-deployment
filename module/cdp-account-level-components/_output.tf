output "cdp_access_connector" {
  value = azurerm_databricks_access_connector.cdp_access_connector
}

output "cdp_storage_credential" {
  value = databricks_storage_credential.cdp_storage_credential
}

# Groups
output "cdp_catalog_users_group" {
  value = databricks_group.catalog_users
}
output "cdp_entra_groups" {
  value = databricks_group.entra_groups
}
output "cdp_bronze_rw_group" {
  value = databricks_group.bronze_rw
}
output "cdp_bronze_ro_group" {
  value = databricks_group.bronze_ro
}
output "cdp_silver_rw_group" {
  value = databricks_group.silver_rw
}
output "cdp_silver_ro_group" {
  value = databricks_group.silver_ro
}
output "cdp_gold_rw_group" {
  value = databricks_group.gold_rw
}
output "cdp_gold_ro_group" {
  value = databricks_group.gold_ro
}
output "cdp_staging_inbound_group" {
  value = databricks_group.staging_inbound
}
output "cdp_staging_outbound_group" {
  value = databricks_group.staging_outbound
}
output "cdp_functions_ro_group" {
  value = databricks_group.functions_ro
}
output "cdp_functions_rw_group" {
  value = databricks_group.functions_rw
}
output "cdp_audit_ro_group" {
  value = databricks_group.audit_ro
}
output "cdp_audit_rw_group" {
  value = databricks_group.audit_rw
}

# Service Principals
output "cdp_rw_sps" {
  value = databricks_service_principal.rw
}
output "cdp_ro_sps" {
  value = databricks_service_principal.ro
}
output "cdp_workspace_admin_sp" {
  value = databricks_service_principal.workspace_admin_sp
}