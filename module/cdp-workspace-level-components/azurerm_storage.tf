# Stage Storage Configuration
resource "azurerm_storage_account" "cdp_stage_storage_account" {
  name                     = "cdpstage${var.env}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  is_hns_enabled           = true
  sftp_enabled             = true

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "cdp_catalog_storage_stage" {
  name               = "cdp-catalog-storage-stage"
  storage_account_id = azurerm_storage_account.cdp_stage_storage_account.id
}

resource "azurerm_role_assignment" "storage_account_access_stage" {
  scope                = azurerm_storage_account.cdp_stage_storage_account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_databricks_access_connector.cdp_access_connector.identity[0].principal_id
}