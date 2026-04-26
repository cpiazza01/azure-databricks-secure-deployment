# resource "databricks_mws_permission_assignment" "account_admin" {
#   workspace_id = local.workspace_id
#   principal_id = data.databricks_service_principal.account_admin_sp.id
#   permissions  = ["ADMIN"]
#   depends_on   = [databricks_metastore_assignment.this]
# }

# resource "databricks_mws_permission_assignment" "workspace_admins" {
#   workspace_id = local.workspace_id
#   principal_id = local.workspace_admin_group.id
#   permissions  = ["ADMIN"]
#   depends_on   = [databricks_metastore_assignment.this]
# }

# # Access group workspace assignments
# resource "databricks_mws_permission_assignment" "catalog_users" {
#   workspace_id = local.workspace_id
#   principal_id = databricks_group.catalog_users.id
#   permissions  = ["USER"]
#   depends_on   = [databricks_metastore_assignment.this]
# }
# resource "databricks_mws_permission_assignment" "bronze_rw_group" {
#   workspace_id = local.workspace_id
#   principal_id = databricks_group.bronze_rw.id
#   permissions  = ["USER"]
#   depends_on   = [databricks_metastore_assignment.this]
# }
# resource "databricks_mws_permission_assignment" "bronze_ro_group" {
#   workspace_id = local.workspace_id
#   principal_id = databricks_group.bronze_ro.id
#   permissions  = ["USER"]
#   depends_on   = [databricks_metastore_assignment.this]
# }
# resource "databricks_mws_permission_assignment" "silver_rw_group" {
#   workspace_id = local.workspace_id
#   principal_id = databricks_group.silver_rw.id
#   permissions  = ["USER"]
#   depends_on   = [databricks_metastore_assignment.this]
# }
# resource "databricks_mws_permission_assignment" "silver_ro_group" {
#   workspace_id = local.workspace_id
#   principal_id = databricks_group.silver_ro.id
#   permissions  = ["USER"]
#   depends_on   = [databricks_metastore_assignment.this]
# }
# resource "databricks_mws_permission_assignment" "gold_rw_group" {
#   workspace_id = local.workspace_id
#   principal_id = databricks_group.gold_rw.id
#   permissions  = ["USER"]
#   depends_on   = [databricks_metastore_assignment.this]
# }
# resource "databricks_mws_permission_assignment" "gold_ro_group" {
#   workspace_id = local.workspace_id
#   principal_id = databricks_group.gold_ro.id
#   permissions  = ["USER"]
#   depends_on   = [databricks_metastore_assignment.this]
# }
# resource "databricks_mws_permission_assignment" "staging_inbound_group" {
#   workspace_id = local.workspace_id
#   principal_id = databricks_group.staging_inbound.id
#   permissions  = ["USER"]
#   depends_on   = [databricks_metastore_assignment.this]
# }
# resource "databricks_mws_permission_assignment" "staging_outbound_group" {
#   workspace_id = local.workspace_id
#   principal_id = databricks_group.staging_outbound.id
#   permissions  = ["USER"]
#   depends_on   = [databricks_metastore_assignment.this]
# }
# resource "databricks_mws_permission_assignment" "functions_ro_group" {
#   workspace_id = local.workspace_id
#   principal_id = databricks_group.functions_ro.id
#   permissions  = ["USER"]
#   depends_on   = [databricks_metastore_assignment.this]
# }
# resource "databricks_mws_permission_assignment" "functions_rw_group" {
#   workspace_id = local.workspace_id
#   principal_id = databricks_group.functions_rw.id
#   permissions  = ["USER"]
#   depends_on   = [databricks_metastore_assignment.this]
# }
# resource "databricks_mws_permission_assignment" "audit_ro_group" {
#   workspace_id = local.workspace_id
#   principal_id = databricks_group.audit_ro.id
#   permissions  = ["USER"]
#   depends_on   = [databricks_metastore_assignment.this]
# }
# resource "databricks_mws_permission_assignment" "audit_rw_group" {
#   workspace_id = local.workspace_id
#   principal_id = databricks_group.audit_rw.id
#   permissions  = ["USER"]
#   depends_on   = [databricks_metastore_assignment.this]
# }