########################################
# Cluster 基本情報
########################################

output "cluster_name" {
  description = "GKE cluster name"
  value       = google_container_cluster.cluster.name
}

output "cluster_id" {
  description = "GKE cluster ID"
  value       = google_container_cluster.cluster.id
}

output "cluster_self_link" {
  description = "Self link of the GKE cluster"
  value       = google_container_cluster.cluster.self_link
}

output "cluster_location" {
  description = "Location (region or zone) of the cluster"
  value       = google_container_cluster.cluster.location
}

output "cluster_endpoint" {
  description = "Endpoint of the GKE cluster"
  value       = google_container_cluster.cluster.endpoint
  sensitive   = true
}

output "cluster_master_version" {
  description = "Master (control plane) version"
  value       = google_container_cluster.cluster.master_version
}

output "cluster_network" {
  description = "Network used by the cluster"
  value       = google_container_cluster.cluster.network
}

output "cluster_subnetwork" {
  description = "Subnetwork used by the cluster"
  value       = google_container_cluster.cluster.subnetwork
}

########################################
# 認証 / Workload Identity
########################################

output "cluster_ca_certificate" {
  description = "Cluster CA certificate (base64-encoded)"
  value       = try(google_container_cluster.cluster.master_auth[0].cluster_ca_certificate, null)
  sensitive   = true
}

output "workload_identity_pool" {
  description = "Workload Identity pool (project.svc.id.goog)"
  value       = try(google_container_cluster.cluster.workload_identity_config[0].workload_pool, null)
}

########################################
# ログ / モニタリング
########################################

output "logging_config" {
  description = "Logging configuration for the cluster"
  value       = try(google_container_cluster.cluster.logging_config[0], null)
}

output "monitoring_config" {
  description = "Monitoring configuration for the cluster"
  value       = try(google_container_cluster.cluster.monitoring_config[0], null)
}

########################################
# Private Cluster 関連
########################################

output "private_cluster_config" {
  description = "Private cluster configuration (if enabled)"
  value       = try(google_container_cluster.cluster.private_cluster_config[0], null)
}

output "master_authorized_networks_config" {
  description = "Master authorized networks configuration (if enabled)"
  value       = try(google_container_cluster.cluster.master_authorized_networks_config[0], null)
}

########################################
# CMEK (etcd 暗号化)
########################################

output "cmek_key_id" {
  description = "KMS key ID used for database encryption (if CMEK is enabled)"
  value       = try(data.google_kms_crypto_key.gke_main["cmek"].id, null)
}

########################################
# Node Pool 情報
########################################

output "node_pool_names" {
  description = "List of node pool names"
  value       = [for np in google_container_node_pool.node_pools : np.name]
}

output "node_pools" {
  description = "Node pool details (name, node_count, version, instance groups)"
  value = {
    for k, np in google_container_node_pool.node_pools :
    k => {
      name                = np.name
      node_count          = np.node_count
      version             = np.version
      instance_group_urls = np.instance_group_urls
    }
  }
}

########################################
# 便利系 (kubectl 用など)
########################################

output "gcloud_get_credentials_command" {
  description = "Handy gcloud command to fetch kubeconfig for this cluster"
  value       = "gcloud container clusters get-credentials ${google_container_cluster.cluster.name} --location ${google_container_cluster.cluster.location} --project ${google_container_cluster.cluster.project}"
}
