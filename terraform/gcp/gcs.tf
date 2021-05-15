resource "google_storage_bucket" "terragoat_website" {
  name          = "terragot-${var.environment}"
  force_destroy = true
  labels = {
    git_commit           = "ff3ee8387837a499665630ebb0371be39ce35fb6"
    git_file             = "terraform/gcp/gcs.tf"
    git_last_modified_at = "2020-07-08 12:02:14"
    git_last_modified_by = "nimrodkor@gmail.com"
    git_modifiers        = "nimrodkor"
    git_org              = "try-bridgecrew"
    git_repo             = "terragoat"
    yor_trace            = "6b4a2e7a-c149-4082-91de-72ea665ce0ac"
  }
}

resource "google_storage_bucket_iam_binding" "allow_public_read" {
  bucket  = google_storage_bucket.terragoat_website.id
  members = ["allUsers"]
  role    = "roles/storage.objectViewer"
}

resource "google_storage_bucket" "internal_storage" {
  name          = "terragoat-internal"
  force_destroy = true
  labels = {
    git_commit           = "14c8868a3a13d0c92540595862543e3050df6248"
    git_file             = "terraform/gcp/gcs.tf"
    git_last_modified_at = "2020-07-30 15:31:05"
    git_last_modified_by = "mikeurbanski1@users.noreply.github.com"
    git_modifiers        = "mikeurbanski1"
    git_org              = "try-bridgecrew"
    git_repo             = "terragoat"
    yor_trace            = "8fb535d3-d75b-4557-8f1c-8260b7bc9230"
  }
}
