module "ip_address" {
  source       = "./modules/address"
  name         = var.ip_name
  address_type = var.address_type
  network_tier = var.network_tier
  region       = var.region
}

module "server" {
  source                 = "./modules/instance"
  dependson              = [module.ip_address]
  name                   = var.instance_name
  machine_type           = var.machine_type
  allow_stop_updates     = var.allow_stop_updates
  startup_script         = var.startup_script
  network_tags           = var.network_tags
  boot_disk_image        = var.boot_disk_image
  boot_disk_size         = var.boot_disk_size
  nat_ip                 = module.ip_address.ip_addr
  zone                   = var.zone
  service_account        = var.service_account
  service_account_scopes = var.service_account_scopes
}
