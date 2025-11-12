variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "secure-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "azs" {
  description = "List of Availability Zones for subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "tags" {
  description = "Map of tags to assign to all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "awsassignment"
    Owner       = "Khush"
  }
}
