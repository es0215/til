resource "google_storage_bucket_object" "main" {
  name   = var.file_name
  source = var.source_file_path
  bucket = var.bucket
}
