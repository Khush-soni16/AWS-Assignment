variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "awsassignment-app"
}

variable "scan_on_push" {
  description = "Enable image scanning on push"
  type        = bool
  default     = true
}

variable "image_tag_mutability" {
  description = "Tag mutability setting for the ECR repository (MUTABLE or IMMUTABLE)"
  type        = string
  default     = "MUTABLE"
}

variable "tags" {
  description = "Tags to assign to ECR resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "awsassignment"
    Owner       = "Khush"
  }
}