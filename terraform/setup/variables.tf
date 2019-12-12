variable "bucket" {
  description = "terraform state s3 bucket"
}

variable "dynamodb_table" {
  description = "terraform state lock dynamodb table"
}

variable "key" {
  description = "s3 key for terraform state"
}

variable "profile" {
  description = "aws profile that will be used to run terraform"
}

variable "region" {
  description = "aws region"
}
