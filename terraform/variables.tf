variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Ubuntu 22.04 AMI ID"
  default     = "ami-04b4f1a9cf54c11d0" # ubuntu 64bit
}

variable "ssh_key" {
  description = "attached EC2 instance SSH key"
  default     = "grace"  # Make sure this matches the AWS key pair name
}
