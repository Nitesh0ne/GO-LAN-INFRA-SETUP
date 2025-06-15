output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}


# output block for security group
output "web_sg_id" {
  value = module.web_sg.security_group_id
}

output "db_sg_id" {
  value = module.db_sg.security_group_id
}
