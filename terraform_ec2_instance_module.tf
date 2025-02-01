#main.tf

provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "mySG" {
  name        = var.sg_name

  ingress {
    description      = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.allowed_cidr_blocks
  }
  
  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "myEC2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.mySG.name]
  tags = {
    Name = "my-instance"
  }
}

#variable.tf

variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "sg_name" {
  description = "Name of the security group"
  type        = string
  default     = "security_group"
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the instance"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

#output.tf

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.myEC2.id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.mySG.id
}

#ec2.tf

module "ec2" {
  source        = "./ec2"
  aws_region    = "us-east-1"
  ami_id        = "ami-12345678"
  instance_type = "t2.micro"
  sg_name       = ["sg-12345678"]
}
