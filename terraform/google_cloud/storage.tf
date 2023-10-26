locals {
  project     = "test-00001"
  regin       = "asia-northeast1"
  gcs_enabled = false

  storages = concat([
    {
      name = "test-01"
    },
    ],
    local.gcs_enabled ? [
      {
        name = "test-02"
      },
    ] : [],
  )
}

resource "google_storage_bucket" "main" {
  for_each = { for v in local.storages : v.name => v }

  project  = local.project
  name     = format("%s-%s", local.project, each.value.name)
  location = local.region
}
