output "dev_k8s_node_metadata" {
  description = "ID of the EC2 instance"
  value       = [aws_instance.dev_k8s_node.id,aws_instance.dev_k8s_node.public_ip]
}


