

resource "azurerm_cosmosdb_account" "account" {
  name                = var.dbaccountname
  location            = var.location
  resource_group_name = var.rgname
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
    
     capabilities {
    name = "EnableServerless"

  }
  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }
  geo_location {
    location          = var.location
    failover_priority = 0
  }
  public_network_access_enabled = var.public_network_access_enabled
}


output "accountname" {
  value = azurerm_cosmosdb_account.account.name
  
}
output "account_id" {
  value = azurerm_cosmosdb_account.account.id
  
}