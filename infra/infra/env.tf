variable "env" {
  description = "The environment for the infrastructure"
  type        = string

}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "instance_count" {
    description = "The number of instances to create"
    type        = number
}

variable "instance_type" {
    description = "The type of EC2 instance to create"
    type        = string
}

variable "ec2_ami" {
    description = "The AMI ID for the EC2 instance"
    type        = string
}
variable "hash_key" {
    description = "The hash key for the DynamoDB table"
    type        = string
}
variable "dynamo_name" {
    description = "The name of the DynamoDB table"
    type        = string
}
