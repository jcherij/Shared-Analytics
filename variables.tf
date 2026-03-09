variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "redshift_password" {
  description = "Redshift master password"
  type        = string
  sensitive   = true
  default     = "Analytics123!"
}
