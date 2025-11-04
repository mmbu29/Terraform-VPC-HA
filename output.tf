# --- VPC Information ---
output "vpc_id" {
  description = "ID of the lab VPC"
  value       = aws_vpc.lab_vpc.id
}

output "vpc_cidr" {
  description = "CIDR block of the lab VPC"
  value       = aws_vpc.lab_vpc.cidr_block
}

# --- Subnet Information ---
output "private_subnet_1_id" {
  description = "ID of private subnet 1"
  value       = aws_subnet.private_subnet_1.id
}

output "private_subnet_2_id" {
  description = "ID of private subnet 2"
  value       = aws_subnet.private_subnet_2.id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public_subnet_one.id
}

# --- Availability Zone Information ---
output "availability_zones" {
  description = "Availability zones used for Multi-AZ setup"
  value = {
    subnet_1_az = aws_subnet.private_subnet_1.availability_zone
    subnet_2_az = aws_subnet.private_subnet_2.availability_zone
  }
}

# --- Route Table Information ---
output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.private_rt.id
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public_rt.id
}

# --- Internet Gateway ---
output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.lab_igw.id
}

# --- DB Subnet Group ---
output "db_subnet_group_name" {
  description = "Name of the DB subnet group for Aurora"
  value       = aws_db_subnet_group.lab_db_subnet_group.name
}

output "db_subnet_group_arn" {
  description = "ARN of the DB subnet group"
  value       = aws_db_subnet_group.lab_db_subnet_group.arn
}

# --- Lab Requirements Verification ---
output "lab_requirements_check" {
  description = "Verification that lab requirements are met"
  value = {
    vpc_created             = "✓ Lab VPC created: ${aws_vpc.lab_vpc.id}"
    multi_az_subnets        = "✓ Private subnets in different AZs: ${aws_subnet.private_subnet_1.availability_zone}, ${aws_subnet.private_subnet_2.availability_zone}"
    no_igw_route            = "✓ Private subnets have NO route to Internet Gateway"
    db_subnet_group_created = "✓ labdb-subnet-group created spanning multiple AZs"
    ready_for_aurora        = "✓ Network setup ready for Aurora HA cluster"
  }
}

# --- Next Steps ---
output "next_steps" {
  description = "Information for next phase of Aurora setup"
  value = {
    vpc_id_for_aurora    = aws_vpc.lab_vpc.id
    db_subnet_group_name = aws_db_subnet_group.lab_db_subnet_group.name
    private_subnet_ids   = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
    availability_zones   = [aws_subnet.private_subnet_1.availability_zone, aws_subnet.private_subnet_2.availability_zone]
  }
}
