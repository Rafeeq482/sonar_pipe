provider "aws" {
  region = var.aws_region
}

# Use default VPC if no VPC is provided
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_security_group" "sonar_sg" {
  name        = "sonar_sg"
  description = "Allow SSH and HTTP for SonarQube"
  vpc_id      = var.vpc_id != "" ? var.vpc_id : data.aws_vpc.default.id

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

resource "aws_instance" "sonarqube" {
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id != "" ? var.subnet_id : data.aws_subnet_ids.default.ids[0]
  vpc_security_group_ids = [aws_security_group.sonar_sg.id]

  tags = {
    Name = "SonarQube"
  }
}
