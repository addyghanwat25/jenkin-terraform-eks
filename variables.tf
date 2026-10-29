
variable "ami_id" {
  description = "Amazon Linux AMI ID for us-east-1"
  type        = string

  validation {
    condition     = can(regex("^ami-[0-9a-fA-F]+$", var.ami_id))
    error_message = "Enter a valid AMI ID, such as ami-0123456789abcdef0."
  }
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "instance_name" {
  type    = string
  default = "Student-EC2"
}
