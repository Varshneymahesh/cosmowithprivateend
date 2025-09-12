resource "azurerm_cosmosdb_sql_container" "container" {
    for_each = var.containers
  name                  = each.key
  resource_group_name   = each.value.rgname
  account_name          = each.value.dbaccountname
  database_name         = each.value.dbname
  partition_key_paths   = each.value.partition_key_paths
  partition_key_version = 2
}