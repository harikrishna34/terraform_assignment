terraform {
  required_version = ">= 1.3.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=4.18.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">=4.18.0"
    }
  }

  backend "gcs" {
    bucket = "terraform-state-storage-001"
    prefix = "devops-task"
  }
}
