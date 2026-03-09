output "redshift_endpoint" {
  description = "Redshift cluster endpoint"
  value       = aws_redshift_cluster.main.endpoint
  sensitive   = true
}

output "raw_data_bucket" {
  description = "Raw data S3 bucket name"
  value       = aws_s3_bucket.raw_data.id
}

output "processed_data_bucket" {
  description = "Processed data S3 bucket name"
  value       = aws_s3_bucket.processed_data.id
}
