######################################
###        Global Variables        ###
######################################
variable "project_id" {
  description = "The ID of the project to create the resources."
  type        = string
}

variable "location" {
  description = "The default location project to create resources."
  type        = string
}

variable "network_name" {
  description = "The VPC network to host the cluster in (required)"
  type        = string
}
variable "subnetwork" {
  description = "The subnetwork to host the cluster in (required)"
  type        = string
}

variable "labels" {
  description = " A map of key/value label pairs to assign to the Resource"
  type        = map(string)
  default     = {}
}

variable "gke_cluster_list" {
  description = "The List of the GKE_Clusters can be created."
  type = map(object({
    cluster_name   = string
    node_pool_name = string
    location       = string
    node_locations = list(string)
    machine_type   = string
    cluster_autoscaling = optional(object({
      enabled      = bool
      auto_repair  = optional(bool)
      auto_upgrade = optional(bool)
    }))
    node_version = optional(string)
    node_count   = optional(number)
    metadata     = optional(map(string))
  }))
}
