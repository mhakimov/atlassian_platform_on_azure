resource "azurerm_public_ip" "ingress_ip" {
  name     = "jira-ingress-ip"
  location = azurerm_resource_group.rg.location
  #   resource_group_name = azurerm_resource_group.rg.name
  resource_group_name = azurerm_kubernetes_cluster.aks.node_resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
}