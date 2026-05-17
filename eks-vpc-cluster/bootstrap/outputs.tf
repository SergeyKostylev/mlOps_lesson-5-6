output "state_bucket" {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "Назва bucket-у — скопіюй у backend.hcl"
}

output "region" {
  value = var.region
}
