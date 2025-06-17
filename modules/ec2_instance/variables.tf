
variable "instance_ami" {
  
}
variable "instance_type" {

}
variable "instance_subnet" {
  description = "Subnet ID for the EC2 instance" 
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, prod)"
  type        = string
}


variable "instance_sg" {
  description = "List of security group IDs to associate"
  type = list(string)
}

variable "user_data" {
  description = "user data script"
  type = string
}