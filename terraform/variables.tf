variable "aws_region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "key_name" {
  default = "SNS"
  description = "Existing AWS Key Pair name"
}

variable "vpc_id" {
  default = "vpc-0b43e23e0c149998b"
}

variable "subnet_id" {
  default = "subnet-06cdf6a7520a97aee"
}
