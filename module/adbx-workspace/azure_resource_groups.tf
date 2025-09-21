resource "azurerm_resource_group" "rg_transit" {
  name     = "azure-databricks-rg-transit"
  location = var.location
}

resource "azurerm_resource_group" "rg_dp" {
  name     = "azure-databricks-rg-dp"
  location = var.location
}