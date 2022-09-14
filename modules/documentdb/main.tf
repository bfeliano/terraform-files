resource "aws_docdb_cluster_instance" "cluster_instances" {
  count                = 1
  identifier           = "${var.name}-docdb-inst-${count.index}"
  cluster_identifier   = aws_docdb_cluster.default.id
  instance_class       = var.list-docdb
  apply_immediately    = true
  

  tags = {
    name       = "${var.name}-docdb-instace"
    environment = "production"
  }
}


resource "aws_docdb_cluster" "default" {
  cluster_identifier = "${var.name}"
  availability_zones = ["us-east-1a", "us-east-1b"]
  master_username    = "manager"
  master_password    = "biwlos200B6oqDoq6SYF"
  apply_immediately  = true
  engine_version       = "4.0.0"
  storage_encrypted   =  true
  deletion_protection = true
  preferred_backup_window         = "07:00-09:00"
  preferred_maintenance_window    = "mon:11:00-mon:12:00"
  backup_retention_period         = 31
  vpc_security_group_ids          = ["${aws_security_group.docdb.id}"]
  db_subnet_group_name            = (aws_docdb_subnet_group.default.id)
  skip_final_snapshot             = true



  tags = {
    name       = "${var.name}-docdb-instace"
    environment = "production"
  }

}

resource "aws_security_group" "docdb" {
  name        = "security-group-doc-db"
  description = "allow vpn connectio to db"
  vpc_id      = var.vpc_id



  ingress {
    cidr_blocks = ["IPADDRESS/32"]
    description = "VPN-SSL"
    from_port = 27017
    to_port = 27017
    protocol = "tcp"
  }

  
    ingress {
    cidr_blocks = ["IPADDRESS/20"]
    description = "local"
    from_port = 27017
    to_port = 27017
    protocol = "tcp"
  }


  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
  
}


resource "aws_docdb_subnet_group" "default" {
  name       = "${var.name}-docdb-subnet-group"
  subnet_ids = [var.subnet_id_docdb_1a, var.subnet_id_docdb_1b]

  tags = {
    
    
    environment = "production"
    
    
  }
}