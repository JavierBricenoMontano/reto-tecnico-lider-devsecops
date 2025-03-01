include {
  path = find_in_parent_folders()
  expose = true
}

dependency "resource_group" {
  config_path = "../resource-group"
}

dependency "acr" {
  config_path = "../acr"
}

terraform {
  source = "../../../../modules/aks"
}

inputs = {
  name                = "aks-${include.inputs.company}-${include.inputs.environment}"
  resource_group_name = dependency.resource_group.outputs.name
  location            = dependency.resource_group.outputs.location
  dns_prefix          = "${include.inputs.company}-${include.inputs.environment}-k8s"
  node_count          = include.inputs.aks_node_count
  vm_size             = include.inputs.aks_node_size
  network_plugin      = "kubenet"
  acr_id              = dependency.acr.outputs.id
  tags                = merge(include.inputs.common_tags, include.inputs.environment_tags, include.inputs.region_tags)
}