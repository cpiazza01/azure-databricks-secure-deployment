resource "databricks_sql_endpoint" "group_sql_warehouses" {
  for_each                  = { for index, group in local.cdp_entra_groups : group.display_name => group }
  name                      = "${each.value.display_name} Warehouse"
  cluster_size              = var.env == "prod" ? "X-Small" : "2X-Small"
  min_num_clusters          = 1
  max_num_clusters          = 10
  auto_stop_mins            = 5
  enable_serverless_compute = true
  no_wait                   = true

  tags {
    custom_tags {
      key   = "Team"
      value = upper(each.value.display_name)
    }
  }
}