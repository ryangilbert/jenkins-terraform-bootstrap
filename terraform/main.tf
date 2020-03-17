provider "aws" {
  profile = "default"
  region  = "us-west-1"
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
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.ingress_cidr]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.ingress_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "jenkins" {
  owners      = ["self"]
  most_recent = true

  filter {
    name   = "name"
    values = ["jenkins*"]
  }

}

resource "aws_spot_instance_request" "jenkins-master" {
  ami                         = data.aws_ami.jenkins.id
  spot_price                  = "0.0041"
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  associate_public_ip_address = "true"
  security_groups             = [aws_security_group.jenkins.id]
  key_name                    = "jenkins-ec2-key"
  wait_for_fulfillment        = "true"
  user_data                   = file("user_data/init.yml")
}
