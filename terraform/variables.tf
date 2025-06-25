variable "aws_region" {
  type        = string
  description = "AWS region to deploy to region"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Comma-separated CIDRs for public subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Comma-separated CIDRs for private subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "Comma-separated availability zones"
}


variable "ami_id" {
  type        = string
  description = "AMI ID for EC2 (Amazon Linux 2 or Ubuntu)"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "subnet_id" {
  type        = string
  description = "Subnet to launch the EC2 in"
}
