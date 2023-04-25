output "elasticsearch_version" {
  value = ec_deployment.cloud_deployment.version
}

output "elasticsearch_cloud_id" {
  value = ec_deployment.cloud_deployment.elasticsearch.cloud_id
}

output "elasticsearch_https_endpoint" {
  value = ec_deployment.cloud_deployment.elasticsearch.https_endpoint
}

output "elasticsearch_username" {
  value = ec_deployment.cloud_deployment.elasticsearch_username
}

output "elasticsearch_password" {
  value     = ec_deployment.cloud_deployment.elasticsearch_password
  sensitive = true
}
