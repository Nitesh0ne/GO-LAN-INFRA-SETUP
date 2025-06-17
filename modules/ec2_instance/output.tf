output "instance_metadata" {
  description = "ID of the EC2 instance"
  value       = [aws_instance.this.id,aws_instance.this.public_ip,aws_instance.this.private_ip]
}


