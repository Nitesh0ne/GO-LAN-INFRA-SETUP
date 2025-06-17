#Dev VPC 
locals {
  environment = "dev"
}
module "vpc" {
  source             = "../../modules/vpc"
  vpc_cidr           = "172.16.0.0/16"
  public_subnet_cidr = "172.16.1.0/24"
  az1                = "us-east-1a"
  environment        = local.environment
}

# Security group for web 
module "dev_sg" {
  source        = "../../modules/security_group"
  name          = "dev-sg"
  vpc_id        = module.vpc.vpc_id
  description   = "Dev security group"
  ingress_rules = var.dev_ingress_rules
  egress_rules  = var.dev_egress_rules
}

# ec2 instance 

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Canonical
}

module "ec2_instance" {
  source          = "../../modules/ec2_instance"
  instance_ami    = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  instance_subnet = module.vpc.public_subnet_id
  key_name        = "minikube.pem"
  user_data       = file("${path.module}/install_minikube.sh")
  instance_sg     = [module.dev_sg.security_group_id]
  environment     = local.environment
}
