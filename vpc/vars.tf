variable "stack_name" {
  default = "mystackname"
  description = "Stack name"
}

variable "region" {
  default = "us-east-1"
  description = "AWS region"
}

variable "env" {
  default = "dev"
  description = "Environment"
}

variable "subnet_count" {
  default = "2"
  description = "Number of subnets"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
  description = "CIDR block for VPC"
}

variable "availability_zone_a" {
  default = "us-east-1a"
  description = "Availability zone A"
}

variable "availability_zone_b" {
  default = "us-east-1b"
  description = "Availability zone B"
}

variable "cidr_block_web_a" {
  default = "10.0.0.0/22"
  description = "CIDR block for web tier A"
}

variable "cidr_block_web_b" {
  default = "10.0.4.0/22"
  description = "CIDR block for web tier B"
}