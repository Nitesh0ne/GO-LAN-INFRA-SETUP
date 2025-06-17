
## Vaiable Declaration for security group
variable "dev_ingress_rules" {
  type = list(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups = optional(list(string), [])
  }))
}

variable "dev_egress_rules" {
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
  type        = string
}


variable "bucket_name" {
  description = "this bucket store the state file of dev and prod environment"

}