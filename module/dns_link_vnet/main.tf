resource "azurerm_private_dns_zone_virtual_network_link" "vnetlink" {
  name                  = var.dnslinkname
  resource_group_name   = var.rgname
  private_dns_zone_name = var.dnszonename
  virtual_network_id    = var.vnetid
}