# S3 bucket for raw data ingestion
resource "aws_s3_bucket" "raw_data" {
  bucket = "analytics-raw-data-${var.environment}"

  tags = {
    Name        = "raw-data-bucket"
    DataClass   = "CustomerData"
  }
}

# Enable versioning for data integrity
resource "aws_s3_bucket_versioning" "raw_data" {
  bucket = aws_s3_bucket.raw_data.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Server-side encryption for S3
resource "aws_s3_bucket_server_side_encryption_configuration" "raw_data" {
  bucket = aws_s3_bucket.raw_data.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access to raw data bucket
resource "aws_s3_bucket_public_access_block" "raw_data" {
  bucket = aws_s3_bucket.raw_data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3 bucket for processed analytics results
resource "aws_s3_bucket" "processed_data" {
  bucket = "analytics-processed-data-${var.environment}"

  tags = {
    Name        = "processed-data-bucket"
    DataClass   = "AnalyticsResults"
  }
}

# Enable versioning for processed data
resource "aws_s3_bucket_versioning" "processed_data" {
  bucket = aws_s3_bucket.processed_data.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Server-side encryption for processed data
resource "aws_s3_bucket_server_side_encryption_configuration" "processed_data" {
  bucket = aws_s3_bucket.processed_data.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access to processed data bucket
resource "aws_s3_bucket_public_access_block" "processed_data" {
  bucket = aws_s3_bucket.processed_data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
