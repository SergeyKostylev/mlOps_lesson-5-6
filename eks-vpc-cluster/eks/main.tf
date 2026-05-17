provider "aws" {
  region = var.region
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = var.state_bucket
    key    = "vpc/terraform.tfstate"
    region = var.region
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.kubernetes_version

  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets

  cluster_endpoint_public_access       = true
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    cpu-nodes = {
      instance_types = ["t3.micro"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2

      labels = {
        workload = "cpu"
      }
    }

    gpu-nodes = {
      instance_types = ["t3.micro"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1

      labels = {
        workload = "gpu"
      }
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "mlops"
  }
}
