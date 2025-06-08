aws_region          = "us-east-1"
vpc_cidr            = "172.16.0.0/16"
public_subnet_cidr  = "172.16.1.0/24"

az1                 = "us-east-1a"
az2                 = "us-east-1b"
environment         = "dev"


# varaible Decalration for security group
web_ingress_rules = [
  {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "Allow HTTP-alt"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
   {
    description = "Allow ssh-access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

common_egress_rules = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }
]



# varible for ec2 instance

ami_id        = "ami-05c17b22914ce7378"
instance_type = "t2.medium"
key_name      = "minikube"
file_path  = "./install_minikube.sh"
