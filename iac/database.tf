resource "azurerm_postgresql_flexible_server" "jira" {
  name                = "pg-atlassian"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  administrator_login = "jiraadmin"
  #TODO: change authentication to a secure one
  administrator_password = var.postgres_admin_password

  version = "14"

  sku_name   = "B_Standard_B1ms"
  storage_mb = 32768

  backup_retention_days = 7
  zone                  = "1"

  #TODO: make private
  public_network_access_enabled = true
}

resource "azurerm_postgresql_flexible_server_database" "jira" {
  name      = "jira"
  server_id = azurerm_postgresql_flexible_server.jira.id
  collation = "en_US.utf8"
  charset   = "UTF8"
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_azure" {
  name      = "allow-azure"
  server_id = azurerm_postgresql_flexible_server.jira.id

  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allowed_ips" {
  for_each         = toset(var.allowed_ips)
  name             = replace("allow-${each.key}", ".", "_")
  server_id        = azurerm_postgresql_flexible_server.jira.id
  start_ip_address = each.value
  end_ip_address   = each.value
}
