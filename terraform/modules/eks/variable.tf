variable "cluster_name" {
  type    = string
  default = "secure-eks-cluster"
}

variable "subnet_ids" {
  type = list(string)
}
