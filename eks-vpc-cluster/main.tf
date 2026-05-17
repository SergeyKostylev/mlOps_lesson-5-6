provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./vpc"

  region       = var.region
  cluster_name = var.cluster_name
}

module "eks" {
  source = "./eks"

  region        = var.region
  cluster_name  = var.cluster_name
  state_bucket  = var.state_bucket

  depends_on = [module.vpc]
}
