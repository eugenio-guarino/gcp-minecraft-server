provider "google" {
  project = var.project
  region  = var.region
}

terraform {
  backend "gcs" {
    prefix  = "terraform-state"
  }
}
