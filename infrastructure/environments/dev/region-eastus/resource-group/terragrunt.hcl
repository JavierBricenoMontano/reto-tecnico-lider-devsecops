include {
  path = find_in_parent_folders()
  expose = true
}


terraform {
  source = "../../../../modules/resource-group"
}


inputs = {
  name     = "rg-${include.inputs.company}-${include.inputs.project}-${include.inputs.environment}-${include.inputs.azure_region_code}"
  location = include.inputs.azure_region
  tags     = merge(include.inputs.common_tags, include.inputs.environment_tags, include.inputs.region_tags)
}