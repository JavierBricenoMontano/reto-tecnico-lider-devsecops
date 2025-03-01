# terragrunt.hcl (raíz)
remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    resource_group_name  = "terraform-state-${local.env}"
    storage_account_name = "tfstate${local.env}${local.region_code}"
    container_name       = "tfstate"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
  }
}

# Incluir todas las variables de entorno y región
locals {
  # Cargar variables de entorno
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env = local.env_vars.locals.environment

  # Cargar variables de región
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region      = local.region_vars.locals.azure_region
  region_code = local.region_vars.locals.azure_region_code

  # Variables comunes
  common_vars = read_terragrunt_config(find_in_parent_folders("env-common.hcl"))
}

# Generar providers.tf para todos los módulos
generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  features {}
}
EOF
}

# Variables globales para todos los módulos
inputs = merge(
  local.common_vars.inputs,
  local.env_vars.locals,
  local.region_vars.locals,
)