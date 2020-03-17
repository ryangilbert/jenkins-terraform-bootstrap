output "instance_public_ip" {
  value = aws_spot_instance_request.jenkins-master.public_ip
  description = "The public IP address of the Jenkins instance"
}

output "instance_public_dns" {
  value = aws_spot_instance_request.jenkins-master.public_dns
  description = "The public DNS name of the Jenkins instance"
}
