###  core  ###

provider "aws" {

}


resource "aws_vpc" "Bruno" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

    tags = {
    Name = "${var.name}-vpc"
  }  

}


resource "aws_internet_gateway" "gw" {
  vpc_id = (aws_vpc.Bruno.id)
  
  tags = {
    Name = "${var.name}-igw"
  }
}


resource "aws_subnet" "private" {
  vpc_id            = (aws_vpc.Bruno.id)
  cidr_block        = "10.76.161.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "${var.name}-Private-1b"
  }
}


resource "aws_subnet" "private1" {
  vpc_id            = (aws_vpc.Bruno.id)
  cidr_block        = "10.76.162.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.name}-Private-1a"
  }
}


resource "aws_subnet" "private2" {
  vpc_id            = (aws_vpc.Bruno.id)
  cidr_block        = "10.76.163.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.name}-private-rds-1a"
  }
}


resource "aws_subnet" "private3" {
  vpc_id            = (aws_vpc.Bruno.id)
  cidr_block        = "10.76.164.0/24"
  availability_zone = "us-east-1b"
  
  tags = {
    Name = "${var.name}-private-rds-1b"
  }
}


resource "aws_subnet" "private4" {
  vpc_id            = (aws_vpc.Bruno.id)
  cidr_block        = "10.76.165.0/24"
  availability_zone = "us-east-1a"
  
  tags = {
    Name = "${var.name}-private-docdb-1a"
  }
}


resource "aws_subnet" "private5" {
  vpc_id            = (aws_vpc.Bruno.id)
  cidr_block        = "10.76.166.0/24"
  availability_zone = "us-east-1b"
  
  tags = {
    Name = "${var.name}-private-docdb-1b"
  }
}


resource "aws_subnet" "public" {
  vpc_id            = (aws_vpc.Bruno.id)
  cidr_block        = "10.76.167.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.name}-public-1a"
  }
}


resource "aws_subnet" "public1" {
  vpc_id            = (aws_vpc.Bruno.id)
  cidr_block        = "10.76.168.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "${var.name}-public-1b"
  }
}


resource "aws_security_group" "sg_Bruno_vpn" {
  name        = "${var.name}-vpn-security-group"
  description = "bruno_vpn"
  vpc_id      = (aws_vpc.Bruno.id)

    tags = {
    Name = "${var.name}-vpn-security-group"
  }


  ingress {
    cidr_blocks = ["IPADDRESS/32"]
    description = "BRUNO-VPN-SSL"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }


  ingress {
    cidr_blocks = ["IPADDRESS/32"]
    description = "BRUNO-POLLER-24X7"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }


  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
}




### modules ###


module "route" {
  source             = "../modules/route"
  vpc_id             = (aws_vpc.Bruno.id)
  gateway_id         = (aws_internet_gateway.gw.id)
  name               = var.name
  subnet_id_pub1a    = (aws_subnet.public.id)
  subnet_id_pub1b    = (aws_subnet.public1.id)
  subnet_id1a        = (aws_subnet.private.id)
  subnet_id1b        = (aws_subnet.private1.id)
  subnet_id_rds_1a   = (aws_subnet.private2.id)
  subnet_id_rds_1b   = (aws_subnet.private3.id)
  subnet_id_docdb_1a = (aws_subnet.private4.id)
  subnet_id_docdb_1b = (aws_subnet.private5.id)

}


module "documentdb" {
  source                 = "../modules/documentdb"
  name                   = var.name
  vpc_id                 = (aws_vpc.Bruno.id)
  subnet_id_docdb_1a     = (aws_subnet.private4.id)
  subnet_id_docdb_1b     = (aws_subnet.private5.id)
  list-docdb             = var.list-docdb[0]

}

