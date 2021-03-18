locals {
  cluster_type = "simple-regional"
}

data "google_client_config" "default" {}

provider "kubernetes" {
  load_config_file       = false
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source                      = "terraform-google-modules/kubernetes-engine/google"
  project_id                  = var.project_id
  name                        = var.cluster_name
  regional                    = true
  region                      = var.region
  release_channel             = var.release_channel
  network                     = module.gke_network.network_name
  subnetwork                  = module.gke_network.subnets_names[0]
  ip_range_pods               = "${module.gke_network.subnets_names[0]}-pods"
  ip_range_services           = "${module.gke_network.subnets_names[0]}-services"
  create_service_account      = true
  //service_account             = var.compute_engine_service_account  //TODO: Make variable based on create_service_account
  enable_binary_authorization = var.enable_binary_authorization
  skip_provisioners           = var.skip_provisioners
  
  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "e2-medium"
      min_count          = 1
      max_count          = 100
      local_ssd_count    = 0
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = false
      initial_node_count = 1
    },
  ]

  node_pools_oauth_scopes = {
    all = []
    default-node-pool = [
        "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}