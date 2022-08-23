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

resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name = aws_s3_bucket.bucket.bucket_regional_domain_name
    origin_id   = local.react_app_s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"

  # aliases = ["app-dev.${var.domain}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.react_app_s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/content/immutable/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.react_app_s3_origin_id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/content/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.react_app_s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    Project     = var.stack_name
    Environment = "dev"
    Terraform   = "true"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}