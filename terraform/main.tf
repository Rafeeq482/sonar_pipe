provider "aws" {
  region = var.aws_region
}

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get subnets of the default VPC
data "aws_subnets" "default_vpc" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Security group for SonarQube
resource "aws_security_group" "sonar_sg" {
  name        = "sonar_sg"
  description = "Allow SSH and HTTP for SonarQube"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance for SonarQube
resource "aws_instance" "sonarqube" {
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = data.aws_subnets.default_vpc.ids[0]  # first subnet in default VPC
  vpc_security_group_ids = [aws_security_group.sonar_sg.id]

  tags = {
    Name = "SonarQube"
  }
}
