include {
  path = find_in_parent_folders()
  expose = true
}

dependency "aks" {
  config_path = "../aks"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
  mock_outputs = {
    host = "https://mock-aks.example.com"

    kube_config = [{
      client_certificate     = "c3VwZXIgc2VjcmV0IGNlcnQ="  # Base64 válido simulado
      client_key             = "c3VwZXIgc2VjcmV0IGtleQ=="  # Base64 válido simulado
      cluster_ca_certificate = "c3VwZXIgc2VjcmV0IGNh"  # Base64 válido simulado
    }]
  }
}

terraform {
  source = "../../../../modules/ingress"
}

inputs = {
  kubernetes_config = {
    host                   = dependency.aks.outputs.host
    client_certificate     = dependency.aks.outputs.kube_config.0.client_certificate
    client_key             = dependency.aks.outputs.kube_config.0.client_key
    cluster_ca_certificate = dependency.aks.outputs.kube_config.0.cluster_ca_certificate
  }
  namespace         = "ingress-basic"
  helm_release_name = "nginx-ingress"
  helm_values       = []
}