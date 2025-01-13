# Define the AWS provider
provider "aws" {
  region = "us-east-1" # Change to your desired region
}

resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
