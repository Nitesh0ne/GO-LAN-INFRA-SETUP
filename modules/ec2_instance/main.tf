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

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  vpc_security_group_ids = var.security_group_ids
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name
  user_data = var.user_data 

  tags = {
    Name        = "${var.environment}-app-server"
  }
}
