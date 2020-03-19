# jenkins-terraform-bootstrap
Goal: To bootstrap a light-weight Jenkins instance with auto-scaling replicas using Terraform and EC2 Spot Instances

*NOTE: This is a work in progress! The README will be updated with functional steps as they are added.*

## Replace custom variables for your AWS account
Update the following values in `terraform/remote_state/backend.auto.tfvars`: 
* `bucket` - Where your Terraform state will be stored. Must be globally unique! Example: `"terraform-state-my-project"`

Update the following values in `terraform/network.auto.tfvars`:
* `vpc_id` - VPC that Jenkins will run in. Example: `"vpc-123abcd"`
* `subnet_id` - ID of a public subnet in your VPC. Example: `"subnet-abcd123"`
* `ingress_cidr` - CIDR address for inbound traffic to your Jenkins instance. Example: `"192.168.0.0/24"`
# Setup
Follow these steps to create your Jenkins server from scratch.

## Setup Terraform s3 backend
```bash
cd terraform/remote_state
terraform init
terraform apply
```

## Create image with Packer
This AMI will include the Dockerfile and plugins.txt needed to run the Jenkins docker image.

Before running this, ensure you have set the following env variables:

`export AWS_ACCESS_KEY_ID=YOUR_AWS_ACCESS_KEY`  
`export AWS_SECRET_ACCESS_KEY=YOUR_AWS_SECRET_KEY`

```bash
cd terraform/jenkins
packer validate jenkins_image.json
packer build \
    -var "aws_access_key=${AWS_ACCESS_KEY_ID}" \
    -var "aws_secret_key=${AWS_SECRET_ACCESS_KEY}" \
    jenkins_image.json
```

## Create EC2 instance from Packer image and start Jenkins
```bash
cd terraform
terraform init
terraform apply
```

# Cleanup
Follow these instructions to destroy your Jenkins server and all dependent infrastructure.

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
