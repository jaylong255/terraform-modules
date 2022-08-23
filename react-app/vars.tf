variable "stack_name" {
  description = "The name to use for all the cluster resources"
}

variable "env" {
  description = "Name of environment. I.E dev, demo, prod"
}

variable "region" {
  default = "The AWS region to provision resources in."
}

variable "state_bucket" {
  description = "Name of the S3 bucket that stores the terraform state. Utilized for remote state data source"
}

variable "app" {
  description = "Name of the application"
  default = "reactapp"
}