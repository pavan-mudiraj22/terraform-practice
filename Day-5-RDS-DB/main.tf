# 1. Create VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "dev-vpc"
  }
}

# 2. Create two private subnets for RDS
resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-west-1a"

  tags = {
    Name = "my-subnet-1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-1c"

  tags = {
    Name = "my-subnet-2"
  }
}

# 3. RDS subnet group
resource "aws_db_subnet_group" "my_subnet_group" {
  name = "my-subnet-group"

  subnet_ids = [
    aws_subnet.subnet_1.id,
    aws_subnet.subnet_2.id
  ]

  tags = {
    Name = "my-db-subnet-group"
  }
}

# 4. Security group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "my-rds-security-group"
  description = "Allow MySQL only from the VPC"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "MySQL from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-rds-security-group"
  }
}

# 5. RDS primary MySQL database
resource "aws_db_instance" "primary" {
  identifier        = "mydbinstance"
  allocated_storage = 20
  storage_type      = "gp2"

  engine         = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"

  username = "admin"
  password = "Admin1234"

  db_subnet_group_name   = aws_db_subnet_group.my_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  publicly_accessible = false

  # One day of automated backups
  backup_retention_period = 1

  maintenance_window   = "Mon:00:00-Mon:03:00"
  skip_final_snapshot  = true
  deletion_protection  = false

  tags = {
    Name = "mydbinstance"
  }
}

# 6. RDS read replica
resource "aws_db_instance" "replica" {
  identifier          = "mydbinstance-replica"
  replicate_source_db = aws_db_instance.primary.identifier
  instance_class      = "db.t3.micro"

  publicly_accessible = false

  vpc_security_group_ids = [
    aws_security_group.rds_sg.id
  ]

  skip_final_snapshot = true

  tags = {
    Name = "mydbinstance-replica"
  }
}

# 7. Display database endpoints
output "primary_endpoint" {
  value = aws_db_instance.primary.endpoint
}

output "replica_endpoint" {
  value = aws_db_instance.replica.endpoint
}