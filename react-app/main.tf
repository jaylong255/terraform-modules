# Needed for Terragrunt
terraform {
  backend "s3" {}
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

# Bucket for static site builds.
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.stack_name}-${var.app}-${var.region}-builds"

  tags = {
    Project     = var.stack_name
    Environment = "dev"
    Terraform   = "true"
  }
}

# ACL for the bucket.
resource "aws_s3_bucket_acl" "bucket" {
  bucket = "${aws_s3_bucket.bucket.bucket}"
  acl    = "public-read"
}

# Policy and document
resource "aws_s3_bucket_policy" "bucket" {
  bucket = "${aws_s3_bucket.bucket.bucket}"
  policy = data.aws_iam_policy_document.bucket.json
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

# Access identity, policy and document for the development CDN

locals {
  react_app_s3_origin_id = "S3-${var.stack_name}-${var.app}-${var.region}-builds"
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "CloudFront Origin Access Identity for ${var.stack_name}-${var.app}-${var.region}-builds"
}

