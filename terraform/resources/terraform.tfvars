####################################
## Global ##
####################################
project_id   = "quantum-feat-440302-h0"
location     = "asia-south1"
network_name = "default"
subnetwork   = "default"
labels       = {}

gke_cluster_list = {
  "cluster-1" = {
    cluster_name = "cluster-1"
    node_version = "1.30.5-gke.1014001"
    location     = "asia-south1"
    metadata = {
      disable-legacy-endpoints = "true"
    }
    cluster_autoscaling = {
      enabled = false
    }
    node_count     = 1
    node_pool_name = "gke-cluster-pool-01"
    machine_type   = "e2-medium"
    node_locations = ["asia-south1-b", "asia-south1-a"]
  }
}
