# env.hcl para DEV
locals {
  environment     = "dev"
  
  # Variables específicas para DEV
  aks_node_count  = 1
  aks_node_size   = "Standard_DS2_v2"
  acr_sku         = "Basic"
  
  # Etiquetas específicas para este ambiente
  environment_tags = {
    Environment = "Development"
  }
}
