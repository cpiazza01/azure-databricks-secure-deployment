resource "databricks_catalog" "cdp_catalog" {
  name         = "cdp_${lower(var.env)}"
  storage_root = databricks_external_location.cdp_catalog_root_ext_loc.url
}

resource "databricks_schema" "cdp_bronze_schemas" {
  for_each     = toset(var.cdp_bronze_and_silver_schemas)
  catalog_name = databricks_catalog.cdp_catalog.id
  name         = "bronze_${each.value}"
  comment      = "Schema for holding the raw data ingested from the '${each.value}' data source."
  storage_root = databricks_external_location.cdp_catalog_bronze_ext_loc.url
}

resource "databricks_schema" "cdp_silver_schemas" {
  for_each     = toset(var.cdp_bronze_and_silver_schemas)
  catalog_name = databricks_catalog.cdp_catalog.id
  name         = "silver_${each.value}"
  comment      = "Schema for holding the cleaned/refined data ingested from the '${each.value}' data source."
  storage_root = databricks_external_location.cdp_catalog_silver_ext_loc.url
}

resource "databricks_schema" "cdp_gold_schemas" {
  for_each     = toset(var.cdp_gold_schemas)
  catalog_name = databricks_catalog.cdp_catalog.id
  name         = "gold_${each.value}"
  comment      = "Schema for holding the confirmed data for the '${each.value}' business domain."
  storage_root = databricks_external_location.cdp_catalog_gold_ext_loc.url
}