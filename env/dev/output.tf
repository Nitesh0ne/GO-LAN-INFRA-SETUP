output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

# output block for security group
output "dev_sg_id" {
  value = module.dev_sg.security_group_id
}

