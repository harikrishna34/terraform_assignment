##Required Data Blocks
data "google_compute_subnetwork" "subnetwork" {
  project = var.project_id
  name    = var.subnetwork
  region  = var.region
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "google_container_cluster" "gke_cluster" {
  provider                 = google-beta
  project                  = var.project_id
  name                     = var.cluster_name
  location                 = var.location
  network                  = "projects/${var.project_id}/global/networks/${var.network_name}"
  subnetwork               = "projects/${var.project_id}/regions/${var.region}/subnetworks/${var.subnetwork}"
  networking_mode          = var.networking_mode
  resource_labels          = var.resource_labels
  initial_node_count       = var.initial_node_count
  remove_default_node_pool = true
  enable_shielded_nodes    = true

  cluster_autoscaling {
    enabled = var.cluster_autoscaling.enabled
    dynamic "auto_provisioning_defaults" {
      for_each = var.cluster_autoscaling.enabled == true ? [var.cluster_autoscaling] : []

      content {
        service_account = var.service_account
        oauth_scopes    = var.oauth_scopes

        management {
          auto_repair  = lookup(var.cluster_autoscaling, "auto_repair", true)
          auto_upgrade = lookup(var.cluster_autoscaling, "auto_upgrade", true)
        }
      }
    }
  }
  network_policy {
    enabled  = var.network_policy
    provider = var.network_policy_porvider
  }
  addons_config {
    horizontal_pod_autoscaling {
      disabled = var.horizontal_pod_autoscaling
    }
    http_load_balancing {
      disabled = var.http_load_balancing
    }
    network_policy_config {
      disabled = var.network_policy_config
    }
  }

  dynamic "database_encryption" {
    for_each = var.database_encryption
    content {
      key_name = database_encryption.value.key_name
      state    = database_encryption.value.state
    }
  }

  dynamic "logging_config" {
    for_each = length(var.logging_enabled_components) > 0 ? [1] : []
    content {
      enable_components = var.logging_enabled_components
    }
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = var.issue_client_certificate
    }
  }

  monitoring_config {
    enable_components = var.monitoring_config_components
  }

  release_channel {
    channel = var.release_channel
  }
}
resource "google_container_node_pool" "gke_nodes" {
  location = var.location
  project  = var.project_id

  name           = var.node_pool_name
  cluster        = google_container_cluster.gke_cluster.name
  node_count     = var.node_count
  node_locations = var.node_locations

  node_config {
    disk_size_gb    = var.disk_size_gb
    disk_type       = var.disk_type
    image_type      = var.image_type
    machine_type    = var.machine_type
    metadata        = var.metadata
    oauth_scopes    = var.oauth_scopes
    service_account = var.service_account
    advanced_machine_features {
      enable_nested_virtualization = false
      threads_per_core             = 0
    }
  }
  queued_provisioning {
    enabled = false
  }
  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }
  version = var.node_version


}
