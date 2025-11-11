# =========================
# EKS Cluster Variables
# =========================
variable "cluster_name" {
  description = "Name of the EKS Cluster"
  type        = string
  default     = "secure-eks-cluster"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS Cluster and Node Group"
  type        = list(string)
}

# =========================
# Node Group Configuration
# =========================
variable "node_group_desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "node_group_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "node_group_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 3
}

variable "instance_types" {
  description = "Instance types for the EKS node group"
  type        = list(string)
  default     = ["t3.medium"]
}

# =========================
# AWS Region (Optional)
# =========================
variable "region" {
  description = "AWS region to deploy EKS cluster"
  type        = string
  default     = "us-east-1"
}
