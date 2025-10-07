resource "databricks_metastore_assignment" "this" {
  metastore_id = databricks_metastore.eastus.id
  workspace_id = local.workspace_id
}