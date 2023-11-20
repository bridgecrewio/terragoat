resource "google_storage_bucket" "terragoat_website" {
  name          = "terragot-${var.environment}"
  location      = var.location
  force_destroy = true
  labels = {
    git_file             = "terraform__gcp__test-gcs_tf"
    git_repo             = "terragoat"
  }
  encryption {
    default_kms_key_name = "jf-gcp-project/europe-west2/jf-keyring-euwest/jfkey1"
  }
}

resource "google_storage_bucket_iam_binding" "allow_public_read" {
  bucket  = google_storage_bucket.terragoat_website.id
  members = ["allUsers"]
  role    = "roles/storage.objectViewer"
}