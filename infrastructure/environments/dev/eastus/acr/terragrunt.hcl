include {
  path = find_in_parent_folders()
  expose = true
}

dependency "resource_group" {
  config_path = "../resource-group"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
  mock_outputs = {
    name     = "mock-rg"
    location = "eastus"
  }

}

terraform {
  source = "../../../../modules/acr"
}

inputs = {
  name                = "${include.inputs.company}${include.inputs.environment}acr"
  resource_group_name = dependency.resource_group.outputs.name
  location            = dependency.resource_group.outputs.location
  sku                 = include.inputs.acr_sku
  admin_enabled       = true
  tags                = merge(include.inputs.common_tags, include.inputs.environment_tags, include.inputs.region_tags)
}