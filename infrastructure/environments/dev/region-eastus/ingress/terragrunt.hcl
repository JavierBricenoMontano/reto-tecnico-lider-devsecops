include {
  path = find_in_parent_folders()
  expose = true
}

dependency "aks" {
  config_path = "../aks"
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