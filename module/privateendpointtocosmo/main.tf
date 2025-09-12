resource "azurerm_private_endpoint" "example" {
  name                = var.endpointname
  location            = var.location
  resource_group_name = var.rgname
  subnet_id           = var.subnetid

  private_service_connection {
    name                           = "cosmo-privateserviceconnection"
    private_connection_resource_id = var.private_connection_resource_id
    is_manual_connection           = false
    subresource_names              = ["Sql"]
  }
}