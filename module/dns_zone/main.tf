resource "azurerm_private_dns_zone" "example" {
  name                = var.dnszonename
  resource_group_name = var.rgname
}

output "dnszonename" {
    value = azurerm_private_dns_zone.example.name
  

}
output "dnszoneid" {
    value = azurerm_private_dns_zone.example.id
  
}