# 9. DB Security Group (DBsecGRP) - NEW RESOURCE
resource "aws_security_group" "db_sec_grp" {
  name        = "DBsecGRP"
  description = "Security Group for Aurora, allowing PostgreSQL access (5432) from within the VPC"
  vpc_id      = aws_vpc.lab_vpc.id

  # Ingress rule: Allow PostgreSQL port 5432 from the entire VPC CIDR (10.0.0.0/16)
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "PostgreSQL access from VPC"
  }

  # Egress rule: Allow all outbound traffic
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["10.0.0.0/16"]  # Replace with your internal network range
  description = "Allow outbound traffic within VPC"
}


  tags = {
    Name = "DBsecGRP"
  }
}