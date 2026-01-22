resource "libvirt_network" "this" {
  name      = "simple_machine"
  mode      = "nat"
  addresses = ["10.10.7.0/24"]
  autostart = true
}

resource "libvirt_cloudinit_disk" "this" {
  count     = var.instances
  name      = "simpla_machine-${count.index}.iso"
  user_data = file("${path.module}/cloud_init.cfg")
}

resource "libvirt_volume" "debian_bookworm" {
  count  = var.so == "debian" ? 1 : 0
  name   = "debian_bookworm_amd64"
  source = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2"
}

resource "libvirt_volume" "ubuntu_jammy" {
  count  = var.so == "ubuntu" ? 1 : 0
  name   = "ubuntu_jammy_amd64"
  source = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64-disk-kvm.img"
}

resource "libvirt_volume" "boot" {
  count          = var.instances
  name           = "simple_machine-boot-${count.index}.qcow2"
  base_volume_id = var.so == "ubuntu" ? libvirt_volume.ubuntu_jammy[0].id : libvirt_volume.debian_bookworm[0].id
  size           = 25 * pow(10, 9) # 25GB
  lifecycle {
    ignore_changes = [size]
  }
}

resource "libvirt_domain" "this" {
  count   = var.instances
  name    = "simple_machine-${count.index}"
  vcpu    = 2
  memory  = 4096
  running = false

  cloudinit = libvirt_cloudinit_disk.this[count.index].id

  disk {
    volume_id = libvirt_volume.boot[count.index].id
    scsi      = "true"
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "virtio"
    source_path = "/dev/pts/4"
  }

  network_interface {
    network_id = libvirt_network.this.id
  }

  video {
    type = "vga"
  }
}
