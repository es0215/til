module "gke_base" {
  source   = "./modules/ggogle_cloud/gke"
  project  = var.project
  name     = "example-gke"
  location = "asia-northeast1"

  network    = "projects/${var.project}/global/networks/main"
  subnetwork = "projects/${var.project}/regions/asia-northeast1/subnetworks/main-subnet"

  cluster_secondary_range_name  = "gke-pods"
  services_secondary_range_name = "gke-services"

  enable_private_cluster  = true
  enable_private_endpoint = false
  master_ipv4_cidr_block  = "172.16.0.0/28"

  master_authorized_networks = [
    {
      cidr_block   = "0.0.0.0/0"
      display_name = "any"
    }
  ]

  logging_enabled          = true
  monitoring_enabled       = true
  enable_workload_identity = true

  labels = {
    env = "dev"
  }

  enable_cmek  = true
  key_project  = var.project
  key_location = "asia-northeast1"
  key_ring     = "gke-key-ring"
  key_name     = "gke-etcd-key"

  node_pools = [
    {
      name            = "system-pool"
      node_count      = 1
      machine_type    = "e2-standard-4"
      disk_size_gb    = 100
      disk_type       = "pd-balanced"
      image_type      = "COS_CONTAINERD"
      service_account = "gke-sa@${var.project}.iam.gserviceaccount.com"
      oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
      preemptible     = false
      spot            = false
      labels          = { "pool" = "system" }
      tags            = ["gke-system"]
      metadata        = {}

      auto_repair     = true
      auto_upgrade    = true
      max_surge       = 1
      max_unavailable = 0
    }
  ]
}
