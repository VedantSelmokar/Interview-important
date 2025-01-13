# Define provider
provider "aws" {
  region = var.region
}

# Define an S3 bucket resource
resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name
}

# Define variables
variable "region" {
  description = "The AWS region to create the S3 bucket in."
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

