resource "aws_db_subnet_group" "postgres-subnet" {
  name        = "postgres-subnet"
  description = "RDS subnet group"
  subnet_ids  = [aws_subnet.main-private-1.id, aws_subnet.main-private-2.id]
}

# DB params 
resource "aws_db_parameter_group" "postgres-parameters" {
  name        = "postgres-parameters"
  family      = "postgres11"
  description = "postgres parameter group"
}

# Create DB
resource "aws_db_instance" "postgres" {
  allocated_storage       = 100 
  engine                  = "postgres"
  engine_version          = "11.5"
  instance_class          = "db.t2.small"
  identifier              = "postgres"
  name                    = "postgres"
  username                = "postgres"          
  password                = var.RDS_PASSWORD 
  db_subnet_group_name    = aws_db_subnet_group.postgres-subnet.name
  parameter_group_name    = aws_db_parameter_group.postgres-parameters.name
  multi_az                = "false" # set to true to have high availability: 2 instances synchronized with each other
  vpc_security_group_ids  = [aws_security_group.allow-postgres.id]
  storage_type            = "gp2"
  backup_retention_period = 30                                          
  availability_zone       = aws_subnet.main-private-1.availability_zone
  skip_final_snapshot     = true                                     
  final_snapshot_identifier = "postgres-snapshot"
  tags = {
    Name = "postgres-instance"
  }
}

