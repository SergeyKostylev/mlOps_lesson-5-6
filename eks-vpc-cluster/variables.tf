variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "mlops-eks-cluster"
}

variable "state_bucket" {
  description = "S3 bucket з Terraform state (з bootstrap output)"
  type        = string
}
