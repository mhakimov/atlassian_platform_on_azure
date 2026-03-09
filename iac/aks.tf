resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.project}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  #TODO: revert it back to Private, once I change Azur subscription or enhance vCPU limit to be able to deploy vm bastion
  dns_prefix = "aks-public"

  default_node_pool {
    name       = "system"
    node_count = var.aks_node_count
    vm_size    = "Standard_DC2s_v3"
    vnet_subnet_id = azurerm_subnet.aks.id

    upgrade_settings {
      max_surge                     = "10%"
      drain_timeout_in_minutes      = 0
      node_soak_duration_in_minutes = 0
    }
  }

  identity {
    type = "SystemAssigned"
  }

  azure_active_directory_role_based_access_control {
    managed            = true
    azure_rbac_enabled = true
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"

    outbound_type = "loadBalancer"
  }
}

