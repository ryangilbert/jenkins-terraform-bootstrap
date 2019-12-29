variable "vpc_id" {
  description = "id of the VPC that the Jenkins security group will be created in"
}

variable "ingress_cidr" {
  description = "CIDR addresses for inbound access to ec2 instance"
}

variable "subnet_id" {
  description = "id of the public subnet that ec2 instance will be launched into"
}
