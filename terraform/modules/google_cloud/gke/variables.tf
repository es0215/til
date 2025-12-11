variable "project" {
  type        = string
  description = "GCP project ID"
}

variable "name" {
  type        = string
  description = "GKE cluster name"
}

variable "location" {
  type        = string
  description = "GKE location (region or zone)"
}

variable "network" {
  type        = string
  description = "VPC network self link or name"
}

variable "subnetwork" {
  type        = string
  description = "Subnetwork self link or name"
}

variable "release_channel" {
  type    = string
  default = "REGULAR"
}

variable "cluster_secondary_range_name" {
  type = string
}

variable "services_secondary_range_name" {
  type = string
}

variable "enable_private_cluster" {
  type    = bool
  default = false
}

variable "enable_private_endpoint" {
  type    = bool
  default = false
}

variable "master_ipv4_cidr_block" {
  type    = string
  default = null
}

variable "master_authorized_networks" {
  type = list(object({
    cidr_block   = string
    display_name = string
  }))
  default = []
}

variable "enable_workload_identity" {
  type    = bool
  default = true
}

variable "logging_enabled" {
  type    = bool
  default = true
}

variable "logging_components" {
  type    = list(string)
  default = ["SYSTEM_COMPONENTS", "WORKLOADS"]
}

variable "monitoring_enabled" {
  type    = bool
  default = true
}

variable "monitoring_components" {
  type    = list(string)
  default = ["SYSTEM_COMPONENTS", "WORKLOADS"]
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "maintenance_windows" {
  type = object({
    start_time = string
    end_time   = string
    recurrence = string
  })
  default = null
}

variable "enable_cmek" {
  type    = bool
  default = false
}

variable "key_ring" {
  type    = string
  default = null
}

variable "key_location" {
  type    = string
  default = null
}

variable "key_project" {
  type    = string
  default = null
}

variable "key_name" {
  type    = string
  default = null
}

# Node pool 設定（複数）
variable "node_pools" {
  type = list(object({
    name            = string
    node_count      = number
    machine_type    = string
    disk_size_gb    = number
    disk_type       = string
    image_type      = string
    service_account = string
    oauth_scopes    = list(string)
    preemptible     = bool
    spot            = bool
    labels          = map(string)
    tags            = list(string)
    metadata        = map(string)

    auto_repair     = bool
    auto_upgrade    = bool
    max_surge       = number
    max_unavailable = number
  }))
  default = []
}
