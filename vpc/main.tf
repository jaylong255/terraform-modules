provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
  }
}

# vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
    tags = {
        Name = "${var.stack_name}-${var.env}-vpc"
        Project = var.stack_name
        Environment = var.env
        Terraform = "true"
    }
}

# subnets
resource "aws_subnet" "web_subnet_a" {
  cidr_block = var.cidr_block_web_a
  vpc_id = aws_vpc.vpc.id
  availability_zone = var.availability_zone_a
  map_public_ip_on_launch = false
  tags = {
      Name = "${var.stack_name}-${var.env}-web-subnet-a"
      Project = var.stack_name
      Environment = var.env
      Terraform = "true"
      Type = "private"
      Web = "true"
  }
}

resource "aws_subnet" "web_subnet_b" {
  cidr_block = var.cidr_block_web_b
  vpc_id = aws_vpc.vpc.id
  availability_zone = var.availability_zone_b
  map_public_ip_on_launch = false
  tags = {
      Name = "${var.stack_name}-${var.env}-web-subnet-b"
      Project = var.stack_name
      Environment = var.env
      Terraform = "true"
      Type = "private"
      Web = "true"
  }
}