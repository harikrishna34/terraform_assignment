module "gke_cluster" {
  source       = "../modules/gke-nodepool"
  project_id   = var.project_id
  network_name = var.network_name
  subnetwork   = var.subnetwork
  region       = var.location

  for_each = { for gke_cluster in var.gke_cluster_list : gke_cluster.cluster_name => gke_cluster }

  cluster_name        = each.value.cluster_name
  node_pool_name      = each.value.node_pool_name
  node_version        = each.value.node_version
  node_locations      = each.value.node_locations
  cluster_autoscaling = each.value.cluster_autoscaling
  machine_type        = each.value.machine_type
  metadata            = each.value.metadata
  node_count          = each.value.node_count
  location            = each.value.location
}
