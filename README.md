# jenkins-terraform-bootstrap
Goal: To bootstrap a light-weight Jenkins instance with auto-scaling replicas using Terraform and EC2 Spot Instances

*NOTE: This is a work in progress! The README will be updated with functional steps as they are added.*

## Create AWS infrastructure
Running this setup script will create a security group in your chosen VPC, an EC2 instance,
and a DynamoDB table and s3 bucket for remote terraform state management.

You will be prompted by Terraform to confirm you want to apply the AWS resources, and then to move Terraform state from
local to remote s3 backend.
```bash
cd terraform
./setup.sh
```
