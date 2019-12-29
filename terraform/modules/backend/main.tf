resource "aws_s3_bucket" "terraform-state" {
  bucket = var.bucket
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "expire"
    enabled = true

    noncurrent_version_expiration {
      days = 30
    }
  }

  force_destroy = true
}

resource "aws_dynamodb_table" "terraform-state-lock" {
  name           = var.dynamodb_table
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
