variable "aws_region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t3a.large"
}

variable "key_name" {
  description = "Existing AWS Key Pair name"
}
