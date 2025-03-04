# env-common.hcl
locals {
  company         = "mibanco"
  project         = "devops-challenge"
  owner           = "DevOps-Team"
  
  # Etiquetas comunes para todos los recursos
  common_tags = {
    Project     = local.project
    Owner       = local.owner
    ManagedBy   = "Terraform"
  }
}

inputs = {
  common_tags = local.common_tags
  company = local.company
  project = local.project
  owner = local.owner
}
