variable "aws_region" {
  description = "AWS region for the school environment"
  type        = string
  default     = "us-east-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the school VPC"
  type        = string
  default     = "10.10.0.0/16"
}

variable "external_subnet_cidr" {
  description = "CIDR block for the external subnet"
  type        = string
  default     = "10.10.1.0/24"
}

variable "internal_subnet_cidr" {
  description = "CIDR block for the internal subnet"
  type        = string
  default     = "10.10.2.0/24"
}