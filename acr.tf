resource "azurerm_container_registry" "acr" {
  name                = replace(var.project, "-", "")
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = false
}

# Log Analytics
resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-${var.project}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
