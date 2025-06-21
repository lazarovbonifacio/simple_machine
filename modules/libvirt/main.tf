resource "libvirt_network" "this" {
  name = "simple_machine"
  mode = "nat"
  addresses = ["10.10.7.0/24"]
  autostart = true
}

resource "libvirt_cloudinit_disk" "this" {
  name      = "simpla_machine.iso"
  user_data = file("${path.module}/cloud_init.cfg")
}

resource "libvirt_volume" "debian_bookworm" {
  name   = "debian_bookworm_amd64"
  source = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2"
}

resource "libvirt_volume" "boot" {
  name           = "simple_machine-boot.qcow2"
  base_volume_id = libvirt_volume.debian_bookworm.id
  size = 25 * pow(10,9)  # 25GB
  lifecycle {
    ignore_changes = [ size ]
  }
}

resource "libvirt_domain" "this" {
  name = "simple_machine"
  vcpu = 2
  memory = 4096
  running = false

  cloudinit = libvirt_cloudinit_disk.this.id

  disk {
    volume_id = libvirt_volume.boot.id
    scsi      = "true"
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
    source_path = "/dev/pts/4"
  }

  network_interface {
    network_id = libvirt_network.this.id
  }
}