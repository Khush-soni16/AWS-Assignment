provider "aws" {
  region = var.region
}

module "vpc" {
  source         = "./modules/vpc"
  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
  azs            = var.azs
}

module "eks" {
  source       = "./modules/eks"
  subnet_ids   = module.vpc.subnet_ids
  cluster_name = "secure-eks-cluster"
}
# ECR Module
module "ecr" {
  source = "./ecr"
  repository_name = "awsassignment-app"
  scan_on_push    = true
  tags = {
    Environment = "dev"
    Project     = "awsassignment"
  }
}