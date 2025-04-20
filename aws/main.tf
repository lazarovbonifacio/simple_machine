module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name = "simple_machine"
  cidr = "172.27.0.0/16"

  azs             = ["us-east-1b", "us-east-1c"]
  private_subnets = ["172.27.16.0/20"]
  public_subnets  = ["172.27.112.0/20"]

  tags = {
    camada = "network"
    criticidade = "alta"
  }
}

module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "5.3.0"

  name        = "web_server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc.default_vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = {
    camada = "network"
    criticidade = "alta"
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.8.0"

  name = "simple_machine"

  instance_type = "t3.micro"

  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.web_server_sg.security_group_id]  #, module.ssm_sg.security_group_id]

  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  tags = {
    camada = "computacao"
    criticidade = "media"
  }
}

module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "5.19.0"

  vpc_id = module.vpc.vpc_id

  endpoints = { for service in toset(["ssm", "ssmmessages", "ec2messages"]) :
    replace(service, ".", "_") =>
    {
      service             = service
      subnet_ids          = module.vpc.intra_subnets
      private_dns_enabled = true
      tags                = { Name = "simple_machine_${service}" }
    }
  }

  create_security_group      = true
  security_group_name_prefix = "simple_machine_vpc_endpoints_"
  security_group_description = "VPC endpoint security group"
  security_group_rules = {
    ingress_https = {
      description = "HTTPS from subnets"
      cidr_blocks = module.vpc.intra_subnets_cidr_blocks
    }
  }

  tags = {
    camada = "network"
    criticidade = "baixa"
  }
}

# module "ssm_sg" {
#   source  = "terraform-aws-modules/security-group/aws"
#   version = "~> 5.0"

#   name        = "simple_machine_ssm"
#   description = "Security Group for EC2 Instance Egress"

#   vpc_id = module.vpc.vpc_id

#   egress_rules = ["https-443-tcp"]

#   tags = {
#     camada = "network"
#     criticidade = "baixa"
#   }
# }