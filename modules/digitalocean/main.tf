locals {
  default_name      = "simpleMachine"
  default_user_data = <<-EOT
  #!/bin/bash
  sudo apt update
  sudo apt install nginx -y
  sudo systemctl enable --now nginx
  EOT
}

data "digitalocean_region" "this" {
  slug = "tor1"
}

resource "digitalocean_project" "this" {
  name        = local.default_name
  description = "Mostrar os requisitos mínimos para subir uma máquina em diferentes plataformas e torná-las acessíveis."
  purpose     = "Subir uma VM e torná-la acessível"
  environment = "Development"
}


resource "digitalocean_vpc" "this" {
  name     = local.default_name
  region   = data.digitalocean_region.this.slug
  ip_range = "172.21.0.0/24"
}

data "digitalocean_image" "ubuntu" {
  slug = "ubuntu-22-04-x64"
}

data "digitalocean_image" "debian" {
  slug = "debian-12-x64"
}

resource "digitalocean_droplet" "this" {
  count     = var.instances
  name      = "${local.default_name}-${count.index}"
  size      = "s-1vcpu-2gb"
  image     = var.so == "ubuntu" ? data.digitalocean_image.ubuntu.id : data.digitalocean_image.debian.id
  region    = data.digitalocean_region.this.slug
  vpc_uuid  = digitalocean_vpc.this.id
  user_data = local.default_user_data
}

resource "digitalocean_firewall" "this" {
  name = local.default_name

  droplet_ids = digitalocean_droplet.this[*].id

  dynamic "inbound_rule" {
    for_each = toset(["80", "22"])
    content {
      protocol         = "tcp"
      port_range       = inbound_rule.key
      source_addresses = ["0.0.0.0/0", "::/0"]
    }
  }

  dynamic "outbound_rule" {
    for_each = toset(["tcp", "udp", "icmp"])
    content {
      protocol              = outbound_rule.key
      port_range            = outbound_rule.key == "icmp" ? null : "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    }
  }
}

resource "digitalocean_project_resources" "this" {
  project   = digitalocean_project.this.id
  resources = digitalocean_droplet.this[*].urn
}
