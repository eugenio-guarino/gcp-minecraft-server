resource "google_compute_instance" "default" {
  name                      = var.name
  machine_type              = var.machine_type
  zone                      = var.zone
  allow_stopping_for_update = var.allow_stop_updates
  depends_on                = [var.dependson]
  tags                      = [var.network_tags]

  boot_disk {
    initialize_params {
      image = var.boot_disk_image
      size  = var.boot_disk_size
    }
  }

  network_interface {
    access_config {
      nat_ip = var.nat_ip
    }
  }

  service_account {
    email  = var.service_account
    scopes = var.service_account_scopes
  }

  metadata_startup_script = file(var.startup_script)
}