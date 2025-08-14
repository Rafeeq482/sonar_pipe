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
