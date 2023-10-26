locals {
  project = {
    dev = "dev-00001"
    stg = "stg-00001"
    prd = "prd-00001"
  }
  region = {
    dev = "asia-northeast1"
    stg = "asia-northeast1"
    prd = "asia-northeast1"
  }
  gcs_enabled = {
    dev = true
    stg = false
    prd = false
  }
  module_gcs_enabled = {
    dev = true
    stg = false
    prd = false
  }

  storages = concat([
    "test-01",
    "test-02"
    ],
    local.gcs_enabled[terraform.workspace] ? [
      "test-03"
    ] : [],
  )

  module_storages = concat([
    "module-test-01",
    "module-test-02"
    ],
    local.module_gcs_enabled[terraform.workspace] ? [
      "module-test-03"
    ] : [],
  )
}

resource "google_storage_bucket" "main" {
  for_each = toset(local.storages)

  project  = local.project
  name     = format("%s-%s", local.project, each.value)
  location = local.region[terraform.workspace]
}

module "storages" {
  for_each = toset(local.module_storages)
  source   = "../modules/google_cloud/storage"

  project  = local.project
  name     = format("%s-%s", local.project, each.value)
  location = local.region[terraform.workspace]
}
