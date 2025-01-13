#modules/alb/main.tf — The ALB module

resource "aws_lb" "this" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnets
  enable_deletion_protection = var.enable_deletion_protection

  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  idle_timeout {
    seconds = var.idle_timeout
  }

  tags = var.tags
}

resource "aws_lb_target_group" "this" {
  name     = "${var.name}-target-group"
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    interval            = 30
    path                = var.health_check_path
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 3
    port                = "traffic-port"
    protocol            = "HTTP"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      status_code = "200"
      content_type = "text/plain"
      message_body = "OK"
    }
  }
}

output "load_balancer_arn" {
  value = aws_lb.this.arn
}

output "load_balancer_dns_name" {
  value = aws_lb.this.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.this.arn
}


#modules/alb/variables.tf — Input variables

variable "name" {
  description = "Name of the load balancer"
  type        = string
}

variable "internal" {
  description = "Whether the load balancer is internal"
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "The type of load balancer (e.g., application, network)"
  type        = string
  default     = "application"
}

variable "security_groups" {
  description = "List of security groups for the load balancer"
  type        = list(string)
}

variable "subnets" {
  description = "List of subnets where the load balancer will be deployed"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "enable_deletion_protection" {
  description = "Whether deletion protection is enabled for the load balancer"
  type        = bool
  default     = false
}

variable "enable_cross_zone_load_balancing" {
  description = "Enable cross zone load balancing"
  type        = bool
  default     = true
}

variable "idle_timeout" {
  description = "The idle timeout for the load balancer in seconds"
  type        = number
  default     = 60
}

variable "target_group_port" {
  description = "Port for the target group"
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "Protocol for the target group (e.g., HTTP, HTTPS)"
  type        = string
  default     = "HTTP"
}

variable "health_check_path" {
  description = "Path for the health check"
  type        = string
  default     = "/"
}

variable "tags" {
  description = "Tags to associate with the load balancer"
  type        = map(string)
  default     = {}
}

#modules/alb/outputs.tf — Output variables

output "load_balancer_arn" {
  description = "The ARN of the ALB"
  value       = aws_lb.this.arn
}

output "load_balancer_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.this.arn
}

#main.tf — Using the ALB module

module "alb" {
  source = "./modules/alb"

  name                    = "my-alb"
  security_groups         = ["sg-0123456789abcdef0"]
  subnets                 = ["subnet-12345678", "subnet-87654321"]
  vpc_id                  = "vpc-01234567"
  enable_deletion_protection = true
  tags = {
    Name = "my-alb"
  }
}

output "load_balancer_dns_name" {
  value = module.alb.load_balancer_dns_name
}
