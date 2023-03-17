# Bucket for static site builds.
resource "aws_s3_bucket" "assets" {
  bucket = "${var.stack}-assets-${var.env}"

  tags = {
    Project     = var.stack
    Environment = var.env
    Terraform   = "true"
  }
}