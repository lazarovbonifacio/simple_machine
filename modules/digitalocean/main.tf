locals {
  default_name = "simpleMachine"
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
  name   = local.default_name
  region = data.digitalocean_region.this.slug
  ip_range = "172.21.0.0/24"
}

resource "digitalocean_droplet" "this" {
  name     = local.default_name
  size     = "s-1vcpu-2gb"
  image    = "debian-12-x64"
  region   = data.digitalocean_region.this.slug
  vpc_uuid = digitalocean_vpc.this.id
  user_data = local.default_user_data
}

resource "digitalocean_firewall" "this" {
  name = local.default_name

  droplet_ids = [digitalocean_droplet.this.id]

  dynamic "inbound_rule" {
    for_each = toset([ "80", "22" ])
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
  project = digitalocean_project.this.id
  resources = [
    digitalocean_droplet.this.urn
  ]
}