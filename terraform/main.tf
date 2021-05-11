provider "azurerm" {
  features {}
}

resource "azurerm_kubernetes_cluster" "main" {
  # Removed vars related to: 
  # - sku_tier
  # - enabling private clusters

  # Did not include the following resources within azurerm_kubernetes_cluster: 
  # - linux_profile
  # - linux_profile -> ssh_key
  name                = "${var.prefix}-aks"
  kubernetes_version  = var.kubernetes_version
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.prefix

  default_node_pool {
    # Removed vars related to: 
    # - autoscaling
    # - multiple availability zones
    orchestrator_version = var.orchestrator_version
    name            = var.agents_pool_name
    node_count      = var.agents_count
    vm_size         = var.agents_size
    os_disk_size_gb = var.os_disk_size_gb
    vnet_subnet_id  = var.vnet_subnet_id
    node_labels     = var.agents_labels
    tags            = merge(var.tags, var.agents_tags)
    type            = var.agents_type
  }

  service_principal {
      client_id     = var.client_id
      client_secret = var.client_secret
  }

  role_based_access_control {
    # Removed vars related to: 
    # - client_app_id
    # - server_app_id and server_app_secret

    # Did not include the following resources within role_based_access_control: 
    # - azure_active_directory
    enabled = var.enable_role_based_access_control
  }

  network_profile {
    # Removed optional vars for:
    # dns_service_ip
    # docker_bridge_cidr
    # outbound_type
    # pod_cidr
    # service_cidr  
    network_plugin = var.network_plugin
    network_policy = var.network_policy
  }

  addon_profile { 
    # Remove if kubernetes version is upgraded to +19:
    kube_dashboard {
      enabled = var.enable_kube_dashboard
    }
  }

  tags = var.tags
}

# Removed the following resources:
# - azurerm_log_analytics_workspace
# - azurerm_log_analytics_solution