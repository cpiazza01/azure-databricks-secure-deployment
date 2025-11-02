resource "databricks_cluster_policy" "group_all_purpose_cluster_policies" {
  for_each = { for index, group in local.cdp_entra_groups : group.display_name => group }

  name = "${each.value.display_name} Cluster Policy"

  definition = jsonencode({
    "azure_attributes.availability" : {
      "type" : "fixed",
      "value" : "ON_DEMAND_AZURE"
    },
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 90
    },
    "cluster_log_conf.path" : {
      "type" : "unlimited",
      "defaultValue" : "/Volumes/cdp_${var.env}/audit/cluster_logs_${lower(each.value.display_name)}"
    },
    "cluster_log_conf.type" : {
      "type" : "fixed",
      "value" : "VOLUMES"
    },
    "custom_tags.Team" : {
      "type" : "fixed",
      "value" : each.value.display_name
    },
    "data_security_mode" : {
      "type" : "allowlist",
      "values" : ["SINGLE_USER", "USER_ISOLATION"]
    },
    "node_type_id" : {
      "type" : "allowlist",
      "values" : startswith(each.value.display_name, "CDP_ANALYTICS_TEAM") ? var.cluster_policy_node_types_analytics : var.cluster_policy_node_types_engineers
      "defaultValue" : "Standard_D4pds_v6"
    },
    "runtime_engine" : {
      "type" : "fixed",
      "value" : "STANDARD"
    },
    "spark_conf.spark.databricks.cluster.profile" : {
      "type" : "fixed",
      "value" : "singleNode"
    },
    "spark_version" : {
      "type" : "unlimited",
      "defaultValue" : "auto:latest-lts"
    }
  })
}

resource "databricks_permissions" "cluster_policy_usage" {
  for_each          = databricks_cluster_policy.group_all_purpose_cluster_policies
  cluster_policy_id = each.value.id
  access_control {
    group_name       = split(" Cluster Policy", each.value.name)[0]
    permission_level = "CAN_USE"
  }
}