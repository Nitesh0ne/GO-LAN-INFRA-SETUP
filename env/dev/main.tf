# vpc
module "vpc" {
  source              = "../../modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
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

# Security group go db
module "db_sg" {
  source      = "../../modules/security_group"
  name        = "db-sg"
  vpc_id      = module.vpc.vpc_id
  description = "DB security group"

  ingress_rules = [
    {
      description     = "Allow PostgreSQL from web_sg"
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      cidr_blocks     = []
      security_groups = [module.web_sg.security_group_id]
    }
  ]

  egress_rules = var.common_egress_rules
}

# ec2 instance 

module "ec2_instance" {
  source        = "../../modules/ec2_instance"
  ami_id          = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_cidr
  key_name      = var.key_name
  file_path = var.file_path 
  environment = var.environment



}