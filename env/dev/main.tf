# vpc
module "vpc" {
  source              = "../../modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr

  az1                 = var.az1
  az2                 = var.az2
  environment         = var.environment
}


# Security group for web 
module "web_sg" {
  source      = "../../modules/security_group"
  name        = "web-sg"
  vpc_id      = module.vpc.vpc_id
  description = "Web security group"

  ingress_rules = var.web_ingress_rules
  egress_rules  = var.common_egress_rules
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
  source        = "../../modules/ec2_instance"
  ami_id          = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnet_id
  key_name      = var.key_name
  user_data = file("${path.module}/install_minikube.sh")
  security_group_ids = [module.web_sg.security_group_id]
  
  environment = var.environment

}