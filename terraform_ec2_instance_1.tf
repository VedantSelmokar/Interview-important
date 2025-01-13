#With terraform.tfvars file
#main.tf

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}

#variable.tf

variable "aws_region" {
  description = "The AWS region to deploy the EC2 instance."
  type        = string
  default     = "us-east-1" # You can set a default region
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type."
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance."
  type        = string
  default     = "ExampleInstance"
}

#output.tf

output "instance_id" {
  description = "The ID of the EC2 instance."
  value       = aws_instance.example.id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance."
  value       = aws_instance.example.public_ip
}



