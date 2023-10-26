variable "project" {
  type = string
}

variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "storage_class" {
  type = string
}

variable "object_versioning" {
  type = bool
}

variable "enable_cmek" {
  type    = bool
  default = true
}

variable "force_destroy" {
  type    = bool
  default = false
}

variable "uniform_bucket_level_access" {
  type    = bool
  default = false
}

variable "lifecycle_rules_with_age" {
  type = list(object({
    action_type       = string
    set_storage_class = string
    age               = number
  }))
  default = []
}

variable "lifecycle_rules_with_versioning" {
  type = list(object({
    action_type        = string
    set_storage_class  = string
    num_newer_versions = number
  }))
  default = []
}

variable "logging_enabled" {
  type    = bool
  default = false
}

variable "logging_config" {
  type = object({
    log_bucket        = string
    log_object_prefix = string
  })
  default = null
}

variable "labels" {
  type    = map(string)
  default = null
}

variable "notification_config" {
  type = list(object({
    topic_name  = string
    event_types = list(string)
  }))
  default = []
}

variable "retention_period" {
  type    = number
  default = 0
}

variable "retention_policy_is_locked" {
  type    = string
  default = false
}

variable "default_kms_key_name" {
  type    = string
  default = null
}

variable "key_ring" {
  type    = string
  default = "cloud-storage"
}

variable "key_location" {
  type    = string
  default = null
}

variable "key_project" {
  type    = string
  default = null
}
