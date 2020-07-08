resource "google_storage_bucket" "bad_bucket" {
  name = "terragot-${var.environment}"
}

resource "google_storage_bucket_iam_binding" "allow_public_read" {
  bucket = google_storage_bucket.bad_bucket.id
  members = ["allUsers"]
  role = "roles/storage.objectViewer"
}