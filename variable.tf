
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "Amazon Linux 2023 AMI ID for the selected region"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "Public subnet CIDR block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
  default     = "us-east-1a"
}

variable "instance_name" {
  description = "Name tag for EC2"
  type        = string
  default     = "Terraform-EC2"
}

variable "allowed_ssh_cidr" {
  description = "Public IP address allowed to connect over SSH, in CIDR notation"
  type        = string

  validation {
    condition     = can(cidrhost(var.allowed_ssh_cidr, 0)) && split("/", var.allowed_ssh_cidr)[1] == "32"
    error_message = "Use your public IP address followed by /32, for example 203.0.113.10/32."
  }
}
