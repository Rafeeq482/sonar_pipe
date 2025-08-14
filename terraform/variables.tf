variable "aws_region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "key_name" {
  default = "newacc"
  description = "Existing AWS Key Pair name"
}

variable "vpc_id" {
  default = "vpc-02aec03ff83341eb5"
}

variable "subnet_id" {
  default = "subnet-0016310da050d13e8"
}
