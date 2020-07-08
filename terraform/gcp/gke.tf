data "google_compute_zones" "available_zones" {
  project = var.project
  region  = var.region
}

resource "google_container_cluster" "workload_cluster" {
  name               = "terragoat-${var.environment}-cluster"
  logging_service    = "none"
  location           = data.google_compute_zones.available_zones.names[0]
  initial_node_count = 1

  enable_legacy_abac = true
  monitoring_service = "none"
  remove_default_node_pool = true

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "0.0.0.0/0"
    }
  }
}
