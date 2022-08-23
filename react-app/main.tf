provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
  }
}

# Create an S3 bucket with a cloudfront distribution
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.stack_name}-${var.app}-${var.region}-builds"
  acl    = "public-read"
}
