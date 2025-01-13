# Define Provider
provider "aws" {
  region = "us-east-1" # Specify your preferred region
}

# Define Variables
variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "my-ec2-instance"
}

variable "instance_type" {
  description = "Type of the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the instance"
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # Replace with a valid AMI ID in your region
}

variable "key_name" {
  description = "Key pair name to allow SSH access"
  type        = string
  default     = "my-key-pair" # Replace with your existing key pair
}

# Resource: EC2 Instance
resource "aws_instance" "my_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = var.instance_name
  }
}

# Output the instance information
output "instance_id" {
  value = aws_instance.my_instance.id
}

output "public_ip" {
  value = aws_instance.my_instance.public_ip
}
