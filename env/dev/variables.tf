variable "aws_region" {
  type        = string
  description = "AWS region"
}


variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for the public subnet"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR block for the private subnet"
}

variable "az1" {
  type        = string
  description = "Availability zone for the public subnet"
}

variable "az2" {
  type        = string
  description = "Availability zone for the private subnet"
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, prod)"
}


## Vaiable Declaration for security group
variable "web_ingress_rules" {
  type = list(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups = optional(list(string), [])
  }))
}

variable "common_egress_rules" {
  type = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    ipv6_cidr_blocks = optional(list(string), [])
    prefix_list_ids  = optional(list(string), [])
    security_groups  = optional(list(string), [])
    self             = optional(bool, false)
    description      = optional(string, "")
  }))
}

# varaiblae for ec2instance
variable "ami_id" {
  description = "AMI ID to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}



variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "file_path" {
  description = "*"
  type = string
}



