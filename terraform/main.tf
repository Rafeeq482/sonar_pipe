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
  ami                         = "ami-02d26659fd82cf299"
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = data.aws_subnets.default_vpc.ids[0]
  vpc_security_group_ids      = [aws_security_group.sonar_sg.id]

  root_block_device {
    volume_size           = 15         # Set root EBS volume size to 15 GB
    volume_type           = "gp3"      # Recommended EBS type
    delete_on_termination = true       # Deletes volume when instance is terminated
  }

  tags = {
    Name = "SonarQube"
  }
}

