data "ibm_is_image" "ubuntu" {
  name = "ibm-ubuntu-22-04-minimal-amd64-1"
}

data "ibm_is_image" "debian" {
  name = "ibm-debian-11-9-minimal-amd64-1"
}

resource "ibm_is_vpc" "vpc" {
  name           = "simple-machine-vpc"
  resource_group = var.resource_group_id
}

resource "ibm_is_subnet" "subnet" {
  name            = "simple-machine-subnet"
  vpc             = ibm_is_vpc.vpc.id
  zone            = "us-south-1"
  ipv4_cidr_block = "10.240.0.0/24"
}

resource "ibm_is_security_group" "sg" {
  name           = "simple-machine-sg"
  vpc            = ibm_is_vpc.vpc.id
  resource_group = var.resource_group_id
}

resource "ibm_is_security_group_rule" "inbound_ssh" {
  group     = ibm_is_security_group.sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_security_group_rule" "inbound_http" {
  group     = ibm_is_security_group.sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 80
    port_max = 80
  }
}

resource "ibm_is_instance" "instance" {
  count          = var.instances
  name           = "simple-machine-${count.index}"
  vpc            = ibm_is_vpc.vpc.id
  zone           = "us-south-1"
  keys           = [] # Needs SSH keys but ignoring for structure compilation
  image          = var.so == "ubuntu" ? data.ibm_is_image.ubuntu.id : data.ibm_is_image.debian.id
  profile        = "bx2-2x8"
  resource_group = var.resource_group_id

  primary_network_interface {
    subnet          = ibm_is_subnet.subnet.id
    security_groups = [ibm_is_security_group.sg.id]
  }

  user_data = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    systemctl enable nginx
    systemctl start nginx
    EOF
}
