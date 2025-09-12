resource "azurerm_subnet" "snet" {
    for_each = var.subnets
  name                 = each.key
  resource_group_name  = each.value.rgname
  virtual_network_name = each.value.vnetname
  address_prefixes     = each.value.address_prefixes
}


output "subnet_ids" {
  value = { for k, v in azurerm_subnet.snet : k => v.id }
}