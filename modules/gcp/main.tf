locals {
  default_name = "simple-machine"
  zone = "us-central1-a"
}

data "google_compute_machine_types" "this" {
  zone = local.zone
  filter = "guestCpus = 2 AND memoryMb = 2048 AND isSharedCpu = True"
}

resource "google_service_account" "this" {
  account_id   = "${local.default_name}-sa"
  display_name = "SA for ${local.default_name}"
}

resource "google_compute_instance" "this" {
  name         = local.default_name
  machine_type = data.google_compute_machine_types.this.machine_types[0].name
  zone         = local.zone
  
  tags = [ "http-server" ]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"

    access_config {}
  }

  metadata = { serial-port-enable = true }
  metadata_startup_script = "sudo apt update && sudo apt install -y nginx && sudo systemctl enable --now nginx"

  service_account {
    email  = google_service_account.this.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_firewall" "this" {
  name    = local.default_name
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = [ "0.0.0.0/0" ]
}
