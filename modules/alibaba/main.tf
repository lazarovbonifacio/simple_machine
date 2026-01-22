data "alicloud_zones" "default" {
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = "VSwitch"
}

data "alicloud_images" "ubuntu" {
  owners      = "system"
  name_regex  = "^ubuntu_22_04"
  most_recent = true
}

data "alicloud_images" "debian" {
  owners      = "system"
  name_regex  = "^debian_11" # Debian 12 might not be standard on AliCloud yet, falling back to 11 or checking standard
  most_recent = true
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "simple_machine_vpc"
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alicloud_zones.default.zones.0.id
  vswitch_name = "simple_machine_vsw"
}

resource "alicloud_security_group" "group" {
  security_group_name = "simple_machine_sg"
  vpc_id              = alicloud_vpc.vpc.id
}

resource "alicloud_security_group_rule" "allow_ssh_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/80"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_instance" "instance" {
  count                      = var.instances
  availability_zone          = data.alicloud_zones.default.zones.0.id
  security_groups            = [alicloud_security_group.group.id]
  instance_type              = "ecs.t5-lc1m1.small" # Small burstable instance
  system_disk_category       = "cloud_efficiency"
  image_id                   = var.so == "ubuntu" ? data.alicloud_images.ubuntu.images.0.id : data.alicloud_images.debian.images.0.id
  instance_name              = "simple_machine-${count.index}"
  vswitch_id                 = alicloud_vswitch.vsw.id
  internet_max_bandwidth_out = 10

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y nginx
              systemctl enable nginx
              systemctl start nginx
              EOF
}
