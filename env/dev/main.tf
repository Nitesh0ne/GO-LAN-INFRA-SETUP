# vpc
module "vpc" {
  source              = "../../modules/vpc"
  
  environment         = var.environment
  public_subnet_cidr  = var.public_subnet_cidr
  az1                 = var.az1
  vpc_cidr            = var.vpc_cidr
                 
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


module "ec2_instance" {
  source        = "../../modules/ec2_instance"

  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnet_id
  key_name      = var.key_name
  user_data = file("${path.module}/install_minikube.sh")
  security_group_ids = [module.web_sg.security_group_id]
  
  environment = var.environment

}

module "aws_s3_bucket" {
  source = "../../modules/s3-bucket"
  bucket_name = var.bucket_name 

  
}