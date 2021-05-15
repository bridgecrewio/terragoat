data google_compute_zones "zones" {}

resource google_compute_instance "server" {
  machine_type = "n1-standard-1"
  name         = "terragoat-${var.environment}-machine"
  zone         = data.google_compute_zones.zones.names[0]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
    auto_delete = true
  }
  network_interface {
    subnetwork = google_compute_subnetwork.public-subnetwork.name
    access_config {}
  }
  can_ip_forward = true

  metadata = {
    block-project-ssh-keys = false
    enable-oslogin         = false
    serial-port-enable     = true
  }
  labels = {
    git_commit           = "37914a45800114d263c0dcd74b81b9dd01307e13"
    git_file             = "terraform/gcp/instances.tf"
    git_last_modified_at = "2020-07-09 13:43:30"
    git_last_modified_by = "nimrodkor@gmail.com"
    git_modifiers        = "nimrodkor"
    git_org              = "try-bridgecrew"
    git_repo             = "terragoat"
    yor_trace            = "f3b60229-9824-4961-bc87-3365958badb4"
  }
}

resource google_compute_disk "unencrypted_disk" {
  name = "terragoat-${var.environment}-disk"
  labels = {
    git_commit           = "83661b5e88dd3768c10dbcfa2050c04d85b62fa8"
    git_file             = "terraform/gcp/instances.tf"
    git_last_modified_at = "2020-07-09 13:34:36"
    git_last_modified_by = "nimrodkor@gmail.com"
    git_modifiers        = "nimrodkor"
    git_org              = "try-bridgecrew"
    git_repo             = "terragoat"
    yor_trace            = "db914048-2ec8-4c0f-b081-1a71588b80eb"
  }
}