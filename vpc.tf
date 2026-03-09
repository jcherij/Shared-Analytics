# VPC for the analytics platform
resource "aws_vpc" "main" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "analytics-platform-vpc"
  }
}

# Internet Gateway (for VPC endpoints and NAT if needed)
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "analytics-platform-igw"
  }
}

# Private subnet for Redshift cluster
resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.1.10.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "analytics-private-subnet-a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.1.11.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "analytics-private-subnet-b"
  }
}
