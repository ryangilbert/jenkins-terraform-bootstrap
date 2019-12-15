#!/usr/bin/env sh

# create base infra
terraform init -backend-config=backend.auto.tfvars setup
terraform apply setup

# migrate local state to the remote s3 backend
terraform init -backend-config=backend.auto.tfvars base
