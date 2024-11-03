output "gke_cluster_id" {
  description = "The GKE Cluster identifier whcih is being created"
  value       = google_container_cluster.gke_cluster.id
}

output "gke_cluster_self_link" {
  description = "The GKE Cluster self link which is being created"
  value       = google_container_cluster.gke_cluster.self_link
}

output "gke_cluster_endpoint" {
  description = "The IP address of this cluster's Kubernetes master"
  value       = google_container_cluster.gke_cluster.endpoint
}

output "gke_cluster_services_ipv4_cidr" {
  description = "The IP address range of the Kubernetes services in this cluster, in CIDR notation (e.g. 1.2.3.4/29)."
  value       = google_container_cluster.gke_cluster.services_ipv4_cidr
}

output "gke_cluster_node_pool_id" {
  description = "The GKE Cluster Node pool which is being created"
  value       = google_container_node_pool.gke_nodes.id
}

output "gke_cluster_node_pool_instance_group_urls" {
  description = "The resource URLs of the managed instance groups associated with this node pool"
  value       = google_container_node_pool.gke_nodes.instance_group_urls
}
