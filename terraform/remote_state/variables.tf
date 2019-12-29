variable "bucket" {
  description = "terraform state s3 bucket"
}

variable "dynamodb_table" {
  description = "terraform state lock dynamodb table"
}

variable "key" {
  description = "s3 key for terraform state"
}
