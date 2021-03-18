// Project Variables
variable "project_id" {
  description = "The project ID to host the cluster in"
}

// Networking Variables
/*
variable "subnetwork" {
  description = "The subnetwork to host the cluster in"
}
*/
variable "gke_network_subnet_cidr" {
  description = "The range to use for the GKE node subnet"
}

variable "ip_cidr_range_pods" {
  description = "The secondary ip range to use for pods"
}

variable "ip_cidr_range_services" {
  description = "The secondary ip range to use for services"
}

variable "network_name" {
  description = "The name of the VPC Network to use"
}

// GKE Variables
variable "cluster_name" {
  description = "GKE Cluster name"
  default     = ""
}

variable "region" {
  description = "The region to host the cluster in"
}

variable "compute_engine_service_account" {
  description = "Service account to associate to the nodes in the cluster"
}

variable "release_channel" {
  description = "Release Channel to subscribe the cluster to - UNSPECIFIED, RAPID, REGULAR, or STABLE"
  default     = "RAPID"
}

variable "skip_provisioners" {
  type        = bool
  description = "Flag to skip local-exec provisioners"
  default     = false
}

variable "enable_binary_authorization" {
  description = "Enable BinAuthZ Admission controller"
  default     = false
}

// Lacework Variables