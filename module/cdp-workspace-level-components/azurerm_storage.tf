# CDP Unity Catalog Root Storage Configuration
resource "azurerm_storage_account" "cdp_catalog_root_storage_account" {
  name                     = "cdpcatalogroot${var.env}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  is_hns_enabled           = true
}

resource "azurerm_storage_container" "cdp_catalog_storage_root" {
  name               = "cdp-catalog-storage-root"
  storage_account_id = azurerm_storage_account.cdp_catalog_root_storage_account.id
}

resource "azurerm_role_assignment" "storage_account_access_catalog_root" {
  for_each             = toset(var.storage_account_acceses_to_grant)
  scope                = azurerm_storage_account.cdp_catalog_root_storage_account.id
  role_definition_name = each.value
  principal_id         = local.cdp_access_connector.identity[0].principal_id
}

# Stage Storage Configuration
resource "azurerm_storage_account" "cdp_stage_storage_account" {
  name                     = "cdpstage${var.env}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  is_hns_enabled           = true
}

resource "azurerm_storage_container" "cdp_catalog_storage_stage" {
  name               = "cdp-catalog-storage-stage"
  storage_account_id = azurerm_storage_account.cdp_stage_storage_account.id
}

resource "azurerm_role_assignment" "storage_account_access_stage" {
  for_each             = toset(var.storage_account_acceses_to_grant)
  scope                = azurerm_storage_account.cdp_stage_storage_account.id
  role_definition_name = each.value
  principal_id         = local.cdp_access_connector.identity[0].principal_id
}