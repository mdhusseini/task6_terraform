output "private_key" {
  description = "Private Key"
  value       = tls_private_key.task6key.private_key_pem
  sensitive   = true
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.task6.public_ip
}