resource "linode_instance" "instance" {
  count           = var.instances
  label           = "simple_machine-${count.index}"
  image           = var.so == "ubuntu" ? "linode/ubuntu22.04" : "linode/debian11"
  region          = "us-east"
  type            = "g6-nanode-1"
  authorized_keys = [] # Add keys if provided via variable, or rely on root_pass if essential. Omitting for basic structure.

  # Simple user data via stackscript or direct command isn't as direct as cloud-init usually, 
  # but Linode supports cloud-init on newer images.
  # Using stackscript_data or metadata is possible, but for simplicity:
  # Linode instances often prefer StackScripts for bootstrapping.
  # However, straightforward 'user_data' is not a direct property of linode_instance resource in the same way.
  # But `metadata` block supports access token providing user_data to cloud-init if supported by image.

  metadata {
    user_data = base64encode(<<-EOF
      #!/bin/bash
      apt-get update
      apt-get install -y nginx
      systemctl enable nginx
      systemctl start nginx
      EOF
    )
  }
}
