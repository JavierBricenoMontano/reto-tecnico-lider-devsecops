
output "id" {
  description = "The ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.id
}

output "kube_config" {
  description = "The kube config for the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.kube_config
  sensitive   = true
}

output "kube_config_raw" {
  description = "The raw kube config for the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive   = true
}

output "host" {
  description = "The Kubernetes cluster server host"
  value       = azurerm_kubernetes_cluster.this.kube_config.0.host
  sensitive   = true
}

output "kubelet_identity_object_id" {
  description = "The object ID of the AKS kubelet identity"
  value       = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}
