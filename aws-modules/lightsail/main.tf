# Author: Bruno Feliano
## Date: 15th December 2022
## Purpose: Create an AWS Lightsail Instance and attach a static external IP address to the instance
## Version: 1.0.0
## Terraform documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_instance



## CREATE A NEW WORDPRESS LIGHTSAIL INSTANCE ##

# INSTANCE DETAILS #

resource "aws_lightsail_instance" "lightsail" {
  name              = "name"
  availability_zone = "us-east-1a"
  blueprint_id      = "wordpress"
  bundle_id         = "medium_2_0"
  key_pair_name     = "keyname"
  tags = {
    name = "name"
  }
}



## PROVIDE A STATIC IP ADDRESS AND ATTACH IT TO THE INSTANCE ##

resource "aws_lightsail_static_ip" "ip_address" {
  name = "ip-descompliqi"
}


resource "aws_lightsail_static_ip_attachment" "ip_attach" {
  static_ip_name = aws_lightsail_static_ip.ip_address.id
  instance_name  = aws_lightsail_instance.lightsail.id
}
