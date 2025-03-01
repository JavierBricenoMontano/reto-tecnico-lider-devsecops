provider "helm" {
  kubernetes {
    host                   = var.kubernetes_config.host
    client_certificate     = base64decode(var.kubernetes_config.client_certificate)
    client_key             = base64decode(var.kubernetes_config.client_key)
    cluster_ca_certificate = base64decode(var.kubernetes_config.cluster_ca_certificate)
  }
}

resource "helm_release" "nginx_ingress" {
  name             = var.helm_release_name
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = var.helm_chart_version
  namespace        = var.namespace
  create_namespace = true
  values           = var.helm_values

  set {
    name  = "controller.replicaCount"
    value = "1"
  }

  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-health-probe-request-path"
    value = "/healthz"
  }
}
