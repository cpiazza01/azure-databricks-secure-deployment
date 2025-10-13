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

# Bronze Storage Configuration
resource "azurerm_storage_account" "cdp_bronze_storage_account" {
  name                     = "cdpbronze${var.env}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  is_hns_enabled           = true
}

resource "azurerm_storage_container" "cdp_catalog_storage_bronze" {
  name               = "cdp-catalog-storage-bronze"
  storage_account_id = azurerm_storage_account.cdp_bronze_storage_account.id
}

resource "azurerm_role_assignment" "storage_account_access_bronze" {
  for_each             = toset(var.storage_account_acceses_to_grant)
  scope                = azurerm_storage_account.cdp_bronze_storage_account.id
  role_definition_name = each.value
  principal_id         = local.cdp_access_connector.identity[0].principal_id
}

# Silver Storage Configuration
resource "azurerm_storage_account" "cdp_silver_storage_account" {
  name                     = "cdpsilver${var.env}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  is_hns_enabled           = true
}

resource "azurerm_storage_container" "cdp_catalog_storage_silver" {
  name               = "cdp-catalog-storage-silver"
  storage_account_id = azurerm_storage_account.cdp_silver_storage_account.id
}

resource "azurerm_role_assignment" "storage_account_access_silver" {
  for_each             = toset(var.storage_account_acceses_to_grant)
  scope                = azurerm_storage_account.cdp_silver_storage_account.id
  role_definition_name = each.value
  principal_id         = local.cdp_access_connector.identity[0].principal_id
}

# Gold Storage Configuration
resource "azurerm_storage_account" "cdp_gold_storage_account" {
  name                     = "cdpgold${var.env}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  is_hns_enabled           = true
}

resource "azurerm_storage_container" "cdp_catalog_storage_gold" {
  name               = "cdp-catalog-storage-gold"
  storage_account_id = azurerm_storage_account.cdp_gold_storage_account.id
}

resource "azurerm_role_assignment" "storage_account_access_gold" {
  for_each             = toset(var.storage_account_acceses_to_grant)
  scope                = azurerm_storage_account.cdp_gold_storage_account.id
  role_definition_name = each.value
  principal_id         = local.cdp_access_connector.identity[0].principal_id
}