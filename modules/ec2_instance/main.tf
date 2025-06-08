resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name
  user_data = file(var.file_path)

  tags = {
    Name        = "${var.environment}-app-server"
  }
}
