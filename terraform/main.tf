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
  source                   = "./modules/eks"
  subnet_ids               = module.vpc.subnet_ids
  cluster_name             = "secure-eks-cluster"
  node_group_desired_size  = var.node_group_desired_size
  node_group_min_size      = var.node_group_min_size
  node_group_max_size      = var.node_group_max_size
  instance_types           = var.instance_types
  region                   = var.region
}

# ECR Module
module "ecr" {
  source          = "./modules/ecr"
  repository_name = "awsassignment-app"
}
