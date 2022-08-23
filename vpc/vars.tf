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

variable "cidr_block" {
  default = "10.0.0.0/16"
  description = "CIDR block for VPC"
}