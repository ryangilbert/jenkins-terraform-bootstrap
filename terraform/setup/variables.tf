variable "bucket" {
  description = "terraform state s3 bucket"
}

variable "dynamodb_table" {
  description = "terraform state lock dynamodb table"
}

variable "key" {
  description = "s3 key for terraform state"
}

variable "profile" {
  description = "aws profile that will be used to run terraform"
}

variable "region" {
  description = "aws region"
}

variable "vpc_id" {
  description = "id of the VPC that the Jenkins security group will be created in"
}

variable "ingress_cidr" {
  description = "CIDR addresses for inbound access to ec2 instance"
}

variable "subnet_id" {
  description = "id of the public subnet that ec2 instance will be launched into"
}
