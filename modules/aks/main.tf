# Minimal AKS module (expand per org needs)
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name       = "agentpool"
    node_count = var.node_count
    vm_size    = var.node_vm_size
    # choose network_profile and other fields for Azure CNI/private clusters
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    # For private clusters:
    # load_balancer_sku = "standard"
    # network_policy     = "azure"
  }

  role_based_access_control {
    enabled = true
  }

  tags = var.tags
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}
