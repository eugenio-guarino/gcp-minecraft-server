resource "google_compute_address" "default" {
  name = var.name
  address_type = var.address_type
  network_tier = var.network_tier
  region = var.region
}
