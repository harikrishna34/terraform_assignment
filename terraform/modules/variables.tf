##Global
variable "project_id" {
  description = "The name of the Project ID, the GKE cluster can be created"
  type        = string
}
variable "region" {
  description = "The region where can GKE cluster can be created."
  type        = string
}
variable "network_name" {
  description = "The VPC network to host the cluster in (required)"
  type        = string
}

##Required
variable "cluster_name" {
  description = "The name of the GKE Cluster"
  type        = string
}
variable "subnetwork" {
  description = "The subnetwork to host the cluster in (required)"
  type        = string
}
variable "location" {
  description = "The location where can GKE cluster can be created."
  type        = string
}
variable "metadata" {
  description = "The metadata key/value pairs assigned to instances in the cluster. From GKE 1.12 onwards"
  type        = map(string)
  default     = {}
  nullable    = false
}
variable "node_version" {
  description = "The Kubernetes version on the nodes.Defaults to the default version set by GKE which is not necessarily the latest version."
  type        = string
}
variable "machine_type" {
  description = "The name of a Google Compute Engine machine type. Defaults to e2-medium"
  type        = string
}
variable "node_pool_name" {
  description = "The name of the node pool. If left blank, Terraform will auto-generate a unique name."
  type        = string
}
variable "node_count" {
  description = "The number of nodes per instance group. This field can be used to update the number of nodes per instance group but should not be used alongside autoscaling"
  type        = number
}
variable "node_locations" {
  description = "The list of zones in which the node pool's nodes should be located."
  type        = list(string)
}

##Optional
variable "networking_mode" {
  description = "Determines whether alias IPs or routes will be used for pod IPs in the cluster. Options are VPC_NATIVE or ROUTES"
  type        = string
  validation {
    condition     = can(regex("^(VPC_NATIVE|ROUTE|)$", var.networking_mode))
    error_message = "Only allowed networking_mode values are VPC_NATIVE, ROUTE"
  }
  default = "VPC_NATIVE"
}
variable "resource_labels" {
  description = "The GCE resource labels (a map of key/value pairs) to be applied to the cluster."
  type        = map(string)
  default     = {}
  nullable    = false
}
variable "initial_node_count" {
  description = "The number of nodes to create in this cluster's default node pool. In regional or multi-zonal clusters, this is the number of nodes per zone"
  type        = number
  default     = 0
}
variable "horizontal_pod_autoscaling" {
  description = "The status of the Horizontal Pod Autoscaling addon, which increases or decreases the number of replica pods a replication controller has based on the resource usage of the existing pods"
  type        = bool
  default     = false
}
variable "http_load_balancing" {
  description = "The status of the HTTP (L7) load balancing controller addon, which makes it easy to set up HTTP load balancers for services in a cluster"
  type        = bool
  default     = false
}
variable "network_policy_config" {
  description = "Whether we should enable the network policy addon for the master. This must be enabled in order to enable network policy for the nodes"
  type        = bool
  default     = true
}
variable "service_account" {
  description = "The Google Cloud Platform Service Account to be used by the node VMs created by GKE Autopilot or NAP"
  type        = string
  default     = "default"
}
variable "oauth_scopes" {
  description = "Scopes that are used by NAP and GKE Autopilot when creating node pools"
  type        = list(string)
  default     = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
}
variable "cluster_telemetry" {
  description = "Telemetry integration for the cluster. Supported values (ENABLED, DISABLED, SYSTEM_ONLY"
  type        = string
  default     = "ENABLED"
  validation {
    condition     = can(regex("^(ENABLED|DISABLE|SYSTEM_ONLY|)$", var.cluster_telemetry))
    error_message = "Only allowed cluster_telemetry values are ENABLED, DISABLED, SYSTEM_ONLY"
  }
}
variable "database_encryption" {
  description = "Application-layer Secrets Encryption settings. The object format is {state = string, key_name = string}. Valid values of state are: \"ENCRYPTED\"; \"DECRYPTED\". key_name is the name of a CloudKMS key."
  type        = list(object({ state = string, key_name = string }))

  default = [{
    state    = "DECRYPTED"
    key_name = ""
  }]
}
variable "logging_enabled_components" {
  description = "The GKE components exposing logs. Supported values include: SYSTEM_COMPONENTS, APISERVER, CONTROLLER_MANAGER, and SCHEDULER."
  type        = list(string)
  default     = ["SYSTEM_COMPONENTS", "WORKLOADS"]
}
variable "monitoring_config_components" {
  description = "The GKE components exposing metrics. Supported values include: SYSTEM_COMPONENTS, APISERVER, CONTROLLER_MANAGER, and SCHEDULER. In beta provider, WORKLOADS"
  type        = list(string)
  default     = ["SYSTEM_COMPONENTS", "STORAGE", "POD", "DEPLOYMENT", "STATEFULSET", "DAEMONSET", "HPA", "CADVISOR", "KUBELET", ]
}
variable "default_snat_status" {
  description = "GKE SNAT Default SnatStatus contains the desired state"
  type        = bool
  default     = false
}
variable "issue_client_certificate" {
  description = "Whether client certificate authorization is enabled for this cluste"
  type        = bool
  default     = false
}
variable "cluster_autoscaling" {
  description = "value"
  type = object({
    enabled      = bool
    auto_repair  = optional(bool)
    auto_upgrade = optional(bool)
  })
}
variable "release_channel" {
  description = "Configuration options for the Release channel feature, which provide more control over automatic upgrades of your GKE clusters."
  type        = string
  default     = "REGULAR"
}
variable "network_policy" {
  description = "Whether network policy is enabled on the cluster."
  type        = bool
  default     = false
}
variable "network_policy_porvider" {
  description = "The selected network policy provider. Defaults to PROVIDER_UNSPECIFIED."
  type        = string
  default     = "PROVIDER_UNSPECIFIED"
}
variable "disk_size_gb" {
  description = "Size of the disk attached to each node, specified in GB. The smallest allowed disk size is 10GB."
  type        = number
  default     = 10
}
variable "disk_type" {
  description = "Type of the disk attached to each node (e.g. 'pd-standard', 'pd-ssd' or 'pd-balanced')."
  type        = string
  default     = "pd-standard"
}
variable "image_type" {
  description = "The default image type used by NAP once a new node pool is being created."
  type        = string
  default     = "COS_CONTAINERD"
}
