# Define the AWS provider
provider "aws" {
  region = "us-east-1" # Change to your desired region
}

# Create an S3 bucket
  resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name" # Replace with a globally unique bucket name
  acl = "private"   # Apply bucket policy for public access prevention

  # Enable versioning
  versioning {
    enabled = true
  }
