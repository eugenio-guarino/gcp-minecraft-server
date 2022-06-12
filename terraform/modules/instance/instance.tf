resource "google_compute_instance" "default" {
  name                      = var.name
  machine_type              = var.machine_type
  zone                      = var.zone
  allow_stopping_for_update = var.allow_stop_updates
  depends_on                = [var.dependson]
  tags                      = var.network_tags

  boot_disk {
    initialize_params {
      image = var.boot_disk_image
      size  = var.boot_disk_size
    }
  }

  network_interface {
    network = "default"
    
    access_config {
      nat_ip = var.nat_ip
      network_tier = "STANDARD"
    }
  }

  service_account {
    email  = var.service_account
    scopes = var.service_account_scopes
  }

  scheduling {
    preemptible = true
    automatic_restart = false
    provisioning_model = "SPOT"
  }

  metadata = {
    shutdown-script = file(var.shutdown_script)
  }

  metadata_startup_script = file(var.startup_script)
}