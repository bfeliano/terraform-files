variable "vpc_id" {
  description = "vpc id"
  type        = string
  default     = "vpc_id"

}


variable "sg-env" {
  description = "security_groups-env"
  type        = string
  default     = "module.security_group.aws_security_group.fargate.id"

}


variable "sg-lb" {
  description = "security_groups-lb"
  type        = string
  default     = "module.security_group.aws_security_group.internet_facing.id"

}



variable "name" {
  description = "name for customers account"
  type        = string
  default     = "customer"

}


variable "subnet_id1a" {
  description = "subnet id1a"
  type        = string
  default     = "subnet_id1a"

}


variable "subnet_id1b" {
  description = "subnet id1b"
  type        = string
  default     = "subnet_id1b"

}


variable "subnet_id_pub1a" {
  description = "subnet id1b"
  type        = string
  default     = "subnet_id_pub1a"

}


variable "subnet_id_pub1b" {
  description = "subnet id1b"
  type        = string
  default     = "subnet_id_pub1b"

}

