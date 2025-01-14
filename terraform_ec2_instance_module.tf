#ec2/main.tf

provider "aws" {
  region = var.region
}

resource "aws_instance" "ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id

  tags = merge(
    {
      Name = var.instance_name
    },
    var.tags
  )

  security_group_ids = var.security_group_ids

  user_data = var.user_data
}

#ec2/variables.tf

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ami" {
  description = "AMI ID for the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key name for SSH access"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the instance will be launched"
  type        = string
}

variable "security_group_ids" {
  description = "Security group IDs for the instance"
  type        = list(string)
}

variable "tags" {
  description = "Additional tags for the instance"
  type        = map(string)
  default     = {}
}

variable "user_data" {
  description = "User data script"
  type        = string
  default     = ""
}

variable "instance_name" {
  description = "Name tag for the instance"
  type        = string
  default     = "MyEC2Instance"
}

#ec2/outputs.tf

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.ec2.id
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.ec2.public_ip
}

output "private_ip" {
  description = "Private IP of the EC2 instance"
  value       = aws_instance.ec2.private_ip
}

#main.tf

module "ec2_instance" {
  source             = "./ec2-instance-module"
  region             = "us-east-1"
  ami                = "ami-12345678"
  instance_type      = "t2.micro"
  key_name           = "my-key-pair"
  subnet_id          = "subnet-abcdef12"
  security_group_ids = ["sg-12345678"]
  instance_name      = "MyInstance"
  tags = {
    Environment = "dev"
    Owner       = "myuser"
  }
}

