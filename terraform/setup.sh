#!/usr/bin/env bash

# create base infra
terraform init -backend-config=backend.tfvars setup
terraform apply -var-file=backend.tfvars setup

# migrate local state to the remote s3 backend
terraform init -backend-config=backend.tfvars base
