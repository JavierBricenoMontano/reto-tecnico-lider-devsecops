output "release_name" {
  description = "The name of the helm release"
  value       = helm_release.nginx_ingress.name
}
