module "gke_network" {
    source          = "terraform-google-modules/network/google"
    
    project_id      = var.project_id //TODO: Interpolate from project.tf

    network_name    = var.network_name

    subnets = [
        {
            subnet_name             = "gke-${var.region}"
            subnet_ip               = var.gke_network_subnet_cidr
            subnet_region           = var.region
            subnet_private_access   = true
        },
    ]

    secondary_ranges = {
        "gke-${var.region}" = [
            {
                range_name      = "gke-${var.region}-pods" //TODO:  Make this more programmatic if multiple subnets?
                ip_cidr_range   = var.ip_cidr_range_pods
            },
            {
                range_name      = "gke-${var.region}-services"
                ip_cidr_range   = var.ip_cidr_range_services
            },
        ]
    }
}