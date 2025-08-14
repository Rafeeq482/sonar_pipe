output "sonarqube_public_ip" {
  description = "Public IP of the SonarQube instance"
  value       = aws_instance.sonarqube.public_ip
}
