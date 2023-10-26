resource "google_storage_bucket" "bucket" {
  project                     = var.project
  name                        = var.name
  location                    = var.location
  force_destroy               = var.force_destroy
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_bucket_level_access
  labels                      = var.labels

  versioning {
    enabled = var.object_versioning
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules_with_age
    content {
      action {
        type          = lifecycle_rule.value["action_type"]
        storage_class = lifecycle_rule.value["set_storage_class"]
      }
      condition {
        age        = lifecycle_rule.value["age"]
        with_state = "ANY"
      }
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules_with_versioning
    content {
      action {
        type          = lifecycle_rule.value["action_type"]
        storage_class = lifecycle_rule.value["set_storage_class"]
      }
      condition {
        num_newer_versions = lifecycle_rule.value["num_newer_versions"]
        with_state         = "ARCHIVED"
      }
    }
  }

  dynamic "logging" {
    for_each = [for item in ["dummy"] : var.logging_config if var.logging_enabled]
    content {
      log_bucket        = logging.value["log_bucket"]
      log_object_prefix = logging.value["log_object_prefix"]
    }
  }

  dynamic "retention_policy" {
    for_each = var.retention_period > 0 ? ["dummy"] : []

    content {
      is_locked        = var.retention_policy_is_locked
      retention_period = var.retention_period
    }
  }

  dynamic "encryption" {
    for_each = var.enable_cmek ? toset(["cmek"]) : []

    content {
      default_kms_key_name = data.google_kms_crypto_key.main["cmek"].id
    }
  }
}

data "google_kms_key_ring" "main" {
  for_each = var.enable_cmek ? toset(["cmek"]) : []

  name     = format("%s-%s", var.project, var.key_ring)
  location = var.key_location
  project  = var.key_project
}

data "google_kms_crypto_key" "main" {
  for_each = var.enable_cmek ? toset(["cmek"]) : []

  name     = var.name
  key_ring = data.google_kms_key_ring.main["cmek"].id
}

resource "google_storage_notification" "bucket" {
  for_each = { for notification in var.notification_config :
  notification.topic_name => notification }

  bucket         = google_storage_bucket.bucket.name
  payload_format = "JSON_API_V1"
  topic          = format("projects/%s/topics/%s", var.project, each.value["topic_name"])
  event_types    = each.value["event_types"]

  depends_on = [google_pubsub_topic_iam_member.gcs_account_publisher]
}

data "google_storage_project_service_account" "gcs_account" {
  project = var.project
}

resource "google_project_iam_member" "gcs_account" {
  project = var.project
  role    = "roles/storage.admin"
  member  = "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"
}

resource "google_project_iam_member" "gcs_account_kms" {
  project = var.project
  role    = "roles/cloudkms.cryptoOperator"
  member  = "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"
}

resource "google_pubsub_topic_iam_member" "gcs_account_publisher" {
  for_each = { for notification in var.notification_config :
  notification.topic_name => notification }
  topic  = format("projects/%s/topics/%s", var.project, each.value["topic_name"])
  role   = "roles/pubsub.publisher"
  member = "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"
}
