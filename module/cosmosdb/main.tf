



resource "azurerm_cosmosdb_sql_database" "db" {
  name                = var.dbname
  resource_group_name = var.rgname
  account_name        = var.dbaccountname
  
}

output "dbname" {
  value = azurerm_cosmosdb_sql_database.db.name
}