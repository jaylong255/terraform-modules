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
}

resource "aws_s3_bucket_acl" "bucket" {
  bucket = "${aws_s3_bucket.bucket.bucket}"
  acl    = "public-read"
}