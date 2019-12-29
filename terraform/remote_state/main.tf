provider "aws" {
  profile = "default"
  region  = "us-west-1"
}

module "backend" {
  source = "../modules/backend"

  bucket         = var.bucket
  dynamodb_table = var.dynamodb_table
  key            = var.key
}
