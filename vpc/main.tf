provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
  }
}

# vpc
resource "aws_vpc" "vpc" {
  cidr_block = "var.cidr_block"
  enable_dns_hostnames = true

    tags = {
        Name = "${var.stack_name}-${var.env}-vpc"
        Project = var.stack_name
        Environment = var.env
        Terraform = "true"
    }
}
