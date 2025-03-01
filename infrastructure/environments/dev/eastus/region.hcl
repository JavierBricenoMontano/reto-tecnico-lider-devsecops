# region.hcl para East US
locals {
  azure_region     = "East US"
  azure_region_code = "eastus"
  
  # Etiquetas específicas para esta región
  region_tags = {
    Region = "eastus"
  }
}