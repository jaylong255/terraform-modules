# Needed for Terragrunt
terraform {
  backend "s3" {}
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

# Create an S3 bucket with a cloudfront distribution
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.stack_name}-${var.app}-${var.region}-builds"

  tags = {
    Project     = var.StackName
    Environment = "dev"
    Terraform   = "true"
  }
}

resource "aws_s3_bucket_acl" "bucket" {
  bucket = "${aws_s3_bucket.bucket.bucket}"
  acl    = "public-read"
}

data "aws_iam_policy_document" "bucket" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["s3:GetObject","s3:PutObject","s3:DeleteObject"]

    resources = ["arn:aws:s3:::${var.stack_name}-${var.app}-${var.region}-builds/*"]
  }
}