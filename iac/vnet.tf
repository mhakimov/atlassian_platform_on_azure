resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-atlassian"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "aks" {
  name                 = "snet-aks"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.1.0/24"]
}

# resource "azurerm_route_table" "aks" {
#   name                = "rt-aks-${var.project}"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
# }

# # Associate Route Table to subnet
# resource "azurerm_subnet_route_table_association" "aks" {
#   subnet_id      = azurerm_subnet.aks.id
#   route_table_id = azurerm_route_table.aks.id
# }


#Created for vm-bastion. 
# resource "azurerm_route" "internet" {
#   name                   = "default-internet"
#   resource_group_name    = data.azurerm_resource_group.rg.name
#   route_table_name       = azurerm_route_table.bastion_rt.name
#   address_prefix         = "0.0.0.0/0"
#   next_hop_type          = "Internet"   # change to "VirtualAppliance" if using NAT
# }

# # Associate with Bastion subnet
# resource "azurerm_subnet_route_table_association" "bastion_assoc" {
#   subnet_id      = data.azurerm_subnet.subnet.id
#   route_table_id = azurerm_route_table.bastion_rt.id
# }
