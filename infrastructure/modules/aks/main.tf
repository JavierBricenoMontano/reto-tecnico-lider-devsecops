resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  tags                = var.tags

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = var.network_plugin
    load_balancer_sku = "standard"
  }
}

# Asignar permisos al AKS para acceder al ACR si se proporciona un ID
resource "azurerm_role_assignment" "acr_pull" {
  count                            = var.acr_id != "" ? 1 : 0
  principal_id                     = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = var.acr_id
  skip_service_principal_aad_check = true
}
