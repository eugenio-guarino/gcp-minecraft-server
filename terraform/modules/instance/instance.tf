resource "google_compute_instance" "default" {
  name                      = var.name
  machine_type              = var.machine_type
  zone                      = var.zone
  allow_stopping_for_update = var.allow_stop_updates
  depends_on                = [var.dependson]
  tags                      = var.network_tags

  boot_disk {
    auto_delete = false
    source = "minecraft-server-data"
  }

  network_interface {
    network = "default"
    
    access_config {
      nat_ip = var.nat_ip
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
    instance_termination_action = "DELETE"
  }

  metadata = {
    shutdown-script = file(var.shutdown_script)
  }

  metadata_startup_script = file(var.startup_script)
}