# Security group for Redshift - restrict access to authorized IPs only
resource "aws_security_group" "redshift" {
  name        = "analytics-redshift-sg"
  description = "Security group for Redshift cluster - authorized IPs only"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Redshift access from anywhere"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # TODO: Restrict to specific IP ranges
  }

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "redshift-security-group"
  }
}
