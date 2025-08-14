variable "aws_region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "key_name" {
  description = "Existing AWS Key Pair name"
}

variable "vpc_id" {
  default = ""  # optional, will use default VPC if empty
}

variable "subnet_id" {
  default = ""  # optional, will use first default subnet if empty
}
