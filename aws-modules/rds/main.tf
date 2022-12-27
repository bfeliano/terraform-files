resource "aws_db_instance" "rds" {
  identifier                      = var.name
  instance_class                  = var.list
  allocated_storage               = 20
  max_allocated_storage           = 1000
  engine                          = "postgres"
  engine_version                  = "13.4"
  maintenance_window              = "Mon:05:37-Mon:06:07"
  backup_window                   = "04:22-04:52"
  username                        = "market"
  password                        = "hue12stat2519moncat1"
  publicly_accessible             = false
  skip_final_snapshot             = true
  db_subnet_group_name            = (aws_db_subnet_group.default.id)
  vpc_security_group_ids          = ["${aws_security_group.rds.id}"]
  performance_insights_enabled    = true
  multi_az                        = true
  storage_encrypted               = true 
  deletion_protection             = true 
  backup_retention_period         = 31
  copy_tags_to_snapshot           = true 
  apply_immediately               = true
}


/*resource "aws_ssm_parameter" "pass" {
  name        = "/production/database/master/password/"
  description = "The parameter description"
  type        = "SecureString"
  value       = var.database_master_password

  tags = {
    environment = "production"
  }
}


resource "aws_ssm_parameter" "usr" {
  name        = "/production/database/master/username"
  description = "The parameter description"
  type        = "SecureString"
  value       = var.database_master_username

  tags = {
    environment = "production"
  }
}*/


resource "aws_db_subnet_group" "default" {
  name       = "${var.name}-db_subnet_group"
  subnet_ids = [var.subnet_id_rds_1a, var.subnet_id_rds_1b]

  tags = {
    Name = "${var.name}-db_subnet_group"
  }
}


resource "aws_security_group" "rds" {
  name        = "${var.name}-security-group-rds"
  description = "Allow Trafic from Internet"
  vpc_id      = var.vpc_id

  ingress {
    cidr_blocks = ["IPADDRESS/32"]
    description = "VPN-SSL"
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
  }

  
    ingress {
    cidr_blocks = [var.cidr_local]
    description = "local"
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
  }


  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
}




