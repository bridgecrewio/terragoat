resource "google_storage_bucket" "terragoat_website" {
  name          = "terragot-${var.environment}"
  location      = var.location
  force_destroy = true
  labels = {
    git_commit           = "2bdc0871a5f4505be58244029cc6485d45d7bb8e"
    git_file             = "terraform__gcp__gcs_tf"
    git_last_modified_at = "2022-01-19-17-02-27"
    git_last_modified_by = "jameswoolfenden"
    git_modifiers        = "jameswoolfenden__nimrodkor"
    git_org              = "bridgecrewio"
    git_repo             = "terragoat"
    yor_trace            = "bd00cd2e-f53f-4daf-8d4d-74c47846c1cc"
  }
}

resource "google_storage_bucket_iam_binding" "allow_public_read" {
  bucket  = google_storage_bucket.terragoat_website.id
  members = ["allUsers"]
  role    = "roles/storage.objectViewer"
}

resource "google_compute_instance" "third-instance" {
  name         = "third-instance"
  project      = local.project_id
  machine_type = "e2-small"
  zone         = "us-west1-a"
  tags         = ["valtix-ingress"]
  boot_disk {
    initialize_params {

      image = "debian-cloud/debian-11"
      size  = 30
      type  = "pd-ssd"
    }
  }
  network_interface {
    subnetwork = "default"
  }
  lifecycle {
    ignore_changes = [attached_disk]
  }
  # Required to specify service_account
  allow_stopping_for_update = true
  service_account {
    email  = "cloud-functions-sa@affable-hall-368820.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
  provisioner "local-exec" {
    command = "bash run-script.sh"
  }
  metadata = {
    enable-oslogin = true
  }
  can_ip_forward = false
}
