resource "azurerm_container_registry" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled
  tags                = var.tags
}

output "id" {
  description = "The ID of the container registry"
  value       = azurerm_container_registry.this.id
}

output "login_server" {
  description = "The login server of the container registry"
  value       = azurerm_container_registry.this.login_server
}

output "admin_username" {
  description = "The admin username of the container registry"
  value       = azurerm_container_registry.this.admin_username
}

output "admin_password" {
  description = "The admin password of the container registry"
  value       = azurerm_container_registry.this.admin_password
  sensitive   = true
}
