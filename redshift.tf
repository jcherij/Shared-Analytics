# Redshift subnet group
resource "aws_redshift_subnet_group" "main" {
  name       = "analytics-redshift-subnet-group"
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_b.id]

  tags = {
    Name = "analytics-redshift-subnet-group"
  }
}

# KMS key for Redshift encryption at rest
resource "aws_kms_key" "redshift" {
  description             = "KMS key for Redshift encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = {
    Name = "redshift-encryption-key"
  }
}

resource "aws_kms_alias" "redshift" {
  name          = "alias/analytics-redshift"
  target_key_id = aws_kms_key.redshift.key_id
}

# Redshift cluster for analytics workloads
# Encrypted at rest with customer-managed keys
resource "aws_redshift_cluster" "main" {
  cluster_identifier        = "analytics-cluster"
  database_name             = "analytics"
  master_username           = "admin"
  master_password           = var.redshift_password
  node_type                 = "dc2.large"
  cluster_type              = "multi-node"
  number_of_nodes           = 2
  encrypted                 = true
  kms_key_id                = aws_kms_key.redshift.arn
  vpc_security_group_ids    = [aws_security_group.redshift.id]
  cluster_subnet_group_name = aws_redshift_subnet_group.main.name
  publicly_accessible       = false
  skip_final_snapshot       = false
  final_snapshot_identifier = "analytics-cluster-final-snapshot"

  # Automated snapshots for backup
  automated_snapshot_retention_period = 7

  tags = {
    Name = "analytics-redshift-cluster"
  }
}

# CloudWatch Log Group for Redshift audit logging
resource "aws_cloudwatch_log_group" "redshift_logs" {
  name              = "/aws/redshift/analytics-cluster"
  retention_in_days = 30

  tags = {
    Name = "redshift-audit-logs"
  }
}
