module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.8.0"
}