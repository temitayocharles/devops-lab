output "rds_endpoint" {
  description = "RDS connection endpoint"
  value       = module.rds.db_instance_endpoint
}

output "rds_arn" {
  description = "RDS instance ARN"
  value       = module.rds.db_instance_arn
}

output "kms_key_id" {
  description = "Encryption key ARN"
  value       = aws_kms_key.rds_kms.arn
  sensitive   = true
}