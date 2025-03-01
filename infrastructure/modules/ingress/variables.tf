
variable "kubernetes_config" {
  description = "Kubernetes configuration"
  type = object({
    host                   = string
    client_certificate     = string
    client_key             = string
    cluster_ca_certificate = string
  })
  sensitive = true
}

variable "namespace" {
  description = "Namespace to install the ingress controller"
  type        = string
  default     = "ingress-basic"
}

variable "helm_release_name" {
  description = "Name of the helm release"
  type        = string
  default     = "nginx-ingress"
}

variable "helm_chart_version" {
  description = "Version of the helm chart"
  type        = string
  default     = ""
}

variable "helm_values" {
  description = "Values for the helm chart"
  type        = list(string)
  default     = []
}
