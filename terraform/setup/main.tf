provider "aws" {
  profile = var.profile
  region  = var.region
}

module "backend" {
  source = "../modules/backend"

  bucket         = var.bucket
  dynamodb_table = var.dynamodb_table
  key            = var.key
}


resource "aws_security_group" "jenkins" {
  name        = "jenkins-sg"
  description = "Security group for Jenkins"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ingress_cidr]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.ingress_cidr]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.ingress_cidr]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_spot_instance_request" "jenkins-master" {
  ami                         = data.aws_ami.ubuntu.id
  spot_price                  = "0.0041"
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  associate_public_ip_address = "true"
  security_groups             = [aws_security_group.jenkins.id]
  key_name                    = "jenkins-ec2-key"
  wait_for_fulfillment        = "true"
}
