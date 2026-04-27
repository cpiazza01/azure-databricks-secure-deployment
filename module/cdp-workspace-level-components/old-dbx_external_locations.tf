# # Root
# resource "databricks_external_location" "cdp_catalog_root_ext_loc" {
#   name            = "cdp_catalog_root_ext_loc_${lower(var.env)}"
#   url             = format("abfss://%s@%s.dfs.core.windows.net", azurerm_storage_container.cdp_catalog_storage_root.name, azurerm_storage_account.cdp_catalog_root_storage_account.name)
#   credential_name = local.cdp_storage_credential.id
#   owner           = local.workspace_admin_group.display_name
#   isolation_mode  = "ISOLATION_MODE_ISOLATED"
#   depends_on      = [azurerm_role_assignment.storage_account_access_catalog_root]
# }

# # Bronze
# resource "databricks_external_location" "cdp_catalog_bronze_ext_loc" {
#   name            = "cdp_catalog_bronze_ext_loc_${lower(var.env)}"
#   url             = format("abfss://%s@%s.dfs.core.windows.net", azurerm_storage_container.cdp_catalog_storage_bronze.name, azurerm_storage_account.cdp_bronze_storage_account.name)
#   credential_name = local.cdp_storage_credential.id
#   owner           = local.workspace_admin_group.display_name
#   isolation_mode  = "ISOLATION_MODE_ISOLATED"
#   depends_on      = [azurerm_role_assignment.storage_account_access_bronze]
# }

# # Silver
# resource "databricks_external_location" "cdp_catalog_silver_ext_loc" {
#   name            = "cdp_catalog_silver_ext_loc_${lower(var.env)}"
#   url             = format("abfss://%s@%s.dfs.core.windows.net", azurerm_storage_container.cdp_catalog_storage_silver.name, azurerm_storage_account.cdp_silver_storage_account.name)
#   credential_name = local.cdp_storage_credential.id
#   owner           = local.workspace_admin_group.display_name
#   isolation_mode  = "ISOLATION_MODE_ISOLATED"
#   depends_on      = [azurerm_role_assignment.storage_account_access_silver]
# }

# # Gold
# resource "databricks_external_location" "cdp_catalog_gold_ext_loc" {
#   name            = "cdp_catalog_gold_ext_loc_${lower(var.env)}"
#   url             = format("abfss://%s@%s.dfs.core.windows.net", azurerm_storage_container.cdp_catalog_storage_gold.name, azurerm_storage_account.cdp_gold_storage_account.name)
#   credential_name = local.cdp_storage_credential.id
#   owner           = local.workspace_admin_group.display_name
#   isolation_mode  = "ISOLATION_MODE_ISOLATED"
#   depends_on      = [azurerm_role_assignment.storage_account_access_gold]
# }

# # Staging Inbound
# resource "databricks_external_location" "cdp_staging_inbound_ext_loc" {
#   name            = "cdp_staging_inbound_ext_loc_${lower(var.env)}"
#   url             = format("abfss://%s@%s.dfs.core.windows.net", azurerm_storage_container.cdp_staging_inbound.name, azurerm_storage_account.cdp_staging_inbound_storage_account.name)
#   credential_name = local.cdp_storage_credential.id
#   owner           = local.workspace_admin_group.display_name
#   isolation_mode  = "ISOLATION_MODE_ISOLATED"
#   depends_on      = [azurerm_role_assignment.storage_account_access_staging_inbound]
# }
# resource "databricks_grant" "staging_inbound_ext_loc" {
#   external_location = databricks_external_location.cdp_staging_inbound_ext_loc.id
#   principal         = local.cdp_staging_inbound_group.display_name
#   privileges        = var.cdp_privileges_staging
# }

# # Staging Outbound
# resource "databricks_external_location" "cdp_staging_outbound_ext_loc" {
#   name            = "cdp_staging_outbound_ext_loc_${lower(var.env)}"
#   url             = format("abfss://%s@%s.dfs.core.windows.net", azurerm_storage_container.cdp_staging_outbound.name, azurerm_storage_account.cdp_staging_outbound_storage_account.name)
#   credential_name = local.cdp_storage_credential.id
#   owner           = local.workspace_admin_group.display_name
#   isolation_mode  = "ISOLATION_MODE_ISOLATED"
#   depends_on      = [azurerm_role_assignment.storage_account_access_staging_outbound]
# }
# resource "databricks_grant" "staging_outbound_ext_loc" {
#   external_location = databricks_external_location.cdp_staging_outbound_ext_loc.id
#   principal         = local.cdp_staging_outbound_group.display_name
#   privileges        = var.cdp_privileges_staging
# }