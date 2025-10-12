resource "azurerm_storage_container" "cdp_catalog" {
  name               = "cdp_catalog"
  storage_account_id = data.azurerm_storage_account.cdpdatabrick.id
}