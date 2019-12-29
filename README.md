# jenkins-terraform-bootstrap
Goal: To bootstrap a light-weight Jenkins instance with auto-scaling replicas using Terraform and EC2 Spot Instances

*NOTE: This is a work in progress! The README will be updated with functional steps as they are added.*

## Replace custom variables for your AWS account
Update the following values in `terraform/backend.auto.tfvars`: 
* `bucket` - Where your Terraform state will be stored. Must be globally unique!

Update the following values in `terraform/network.auto.tfvars`:
* `vpc_id` - VPC that Jenkins will run in.
* `subnet_id` - ID of a public subnet in your VPC.
* `ingress_cidr` - CIDR address for inbound traffic to your Jenkins instance.

## Setup Terraform s3 backend
```bash
cd terraform/remote_state
terraform init
terraform apply
```

## Create EC2 instance with Docker and Docker Compose installed
```bash
cd terraform
terraform init
terraform apply
```

## Destroy AWS resources (excluding Terraform state s3 backend)
```bash
cd terraform
terraform destroy
```

## Destroy Terraform s3 backend
This will destroy all Terraform state
```bash
cd terraform/remote_state
terraform destroy
```
