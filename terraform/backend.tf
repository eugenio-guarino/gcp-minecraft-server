provider "google" {
  project = var.project
  region  = var.region
}

terraform {
  backend "gcs" {
      config = {
      bucket  = var.bucket
      prefix  = "terraform-state"
    }
  }
}
