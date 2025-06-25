terraform {
  backend "s3" {
    bucket         = "vikingcloudsysnet"
    key            = "env/infra.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "vikingcloud"
    encrypt        = true
  }
}

# resource "aws_s3_bucket" "tf_state" {
#   bucket        = "vikingcloudsysnet"
#   force_destroy = true
#   tags = {
#     Name = "Terraform State Bucket"
#   }
# }

# resource "aws_s3_bucket_versioning" "tf_state_versioning" {
#   bucket = aws_s3_bucket.tf_state.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_dynamodb_table" "tf_lock" {
#   name         = "vikingcloud"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }

#   tags = {
#     Name = "Terraform Lock Table"
#   }
# }
