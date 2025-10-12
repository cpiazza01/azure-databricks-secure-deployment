output "cdp_access_connector" {
  value = azurerm_databricks_access_connector.cdp_access_connector
}

output "cdp_storage_credential" {
  value = databricks_storage_credential.cdp_storage_credential
}