resource "google_container_cluster" "cluster" {
  project  = var.project
  name     = var.name
  location = var.location

  network    = var.network
  subnetwork = var.subnetwork

  remove_default_node_pool = true
  initial_node_count       = 1

  release_channel {
    channel = var.release_channel
  }

  # Private Cluster
  dynamic "private_cluster_config" {
    for_each = var.enable_private_cluster ? ["enabled"] : []
    content {
      enable_private_nodes    = true
      enable_private_endpoint = var.enable_private_endpoint
      master_ipv4_cidr_block  = var.master_ipv4_cidr_block
    }
  }

  # Master Authorized Networks
  dynamic "master_authorized_networks_config" {
    for_each = length(var.master_authorized_networks) > 0 ? ["enabled"] : []
    content {
      dynamic "cidr_blocks" {
        for_each = var.master_authorized_networks
        content {
          cidr_block   = cidr_blocks.value.cidr_block
          display_name = cidr_blocks.value.display_name
        }
      }
    }
  }

  # IP アロケーション
  ip_allocation_policy {
    cluster_secondary_range_name  = var.cluster_secondary_range_name
    services_secondary_range_name = var.services_secondary_range_name
  }

  # Workload Identity
  dynamic "workload_identity_config" {
    for_each = var.enable_workload_identity ? ["enabled"] : []
    content {
      workload_pool = "${var.project}.svc.id.goog"
    }
  }

  # ログ & メトリクス
  dynamic "logging_config" {
    for_each = var.logging_enabled ? ["enabled"] : []
    content {
      enable_components = var.logging_components
    }
  }

  dynamic "monitoring_config" {
    for_each = var.monitoring_enabled ? ["enabled"] : []
    content {
      enable_components = var.monitoring_components
    }
  }

  # CMEK (Master / etcd の暗号化)
  dynamic "database_encryption" {
    for_each = var.enable_cmek ? ["cmek"] : []
    content {
      state    = "ENCRYPTED"
      key_name = data.google_kms_crypto_key.gke_main["cmek"].id
    }
  }

  # ラベル / アノテーション相当
  resource_labels = var.labels

  # メンテナンス ウィンドウ
  dynamic "maintenance_policy" {
    for_each = length(var.maintenance_windows) > 0 ? ["enabled"] : []
    content {
      recurring_window {
        start_time = var.maintenance_windows.start_time
        end_time   = var.maintenance_windows.end_time
        recurrence = var.maintenance_windows.recurrence
      }
    }
  }

  # Binary Authorization など今後追加しても OK
}

# Node Pool（複数を for_each で作成）
resource "google_container_node_pool" "node_pools" {
  for_each = { for np in var.node_pools : np.name => np }

  project  = var.project
  cluster  = google_container_cluster.cluster.name
  location = var.location
  name     = each.value.name

  node_count = each.value.node_count

  node_config {
    machine_type = each.value.machine_type
    disk_size_gb = each.value.disk_size_gb
    disk_type    = each.value.disk_type
    image_type   = each.value.image_type

    service_account = each.value.service_account
    oauth_scopes    = each.value.oauth_scopes

    preemptible = each.value.preemptible
    spot        = each.value.spot
    labels      = each.value.labels
    tags        = each.value.tags
    metadata    = each.value.metadata
  }

  management {
    auto_repair  = each.value.auto_repair
    auto_upgrade = each.value.auto_upgrade
  }

  upgrade_settings {
    max_surge       = each.value.max_surge
    max_unavailable = each.value.max_unavailable
  }
}

# ---- KMS (CMEK 用) ----

data "google_kms_key_ring" "gke_main" {
  for_each = var.enable_cmek ? toset(["cmek"]) : []

  name     = var.key_ring
  location = var.key_location
  project  = var.key_project
}

data "google_kms_crypto_key" "gke_main" {
  for_each = var.enable_cmek ? toset(["cmek"]) : []

  name     = var.key_name
  key_ring = data.google_kms_key_ring.gke_main["cmek"].id
}
