terraform {
  required_providers {
    lacework = {
      source  = "lacework/lacework"
      //version = "~> 0.2.5"
    }
  }
}

provider "google" {
    project = var.project_id 
    region  = var.region
}