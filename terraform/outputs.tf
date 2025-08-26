output "sonarqube_public_ip" {
  value = aws_instance.sonarqube.public_ip
}

output "security_group_id" {
  value = aws_security_group.sonarqube_sg.id
}

output "subnet_id" {
  value = aws_subnet.sonarqube_subnet.id
}
