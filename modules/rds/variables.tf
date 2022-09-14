variable "name" {
  description = "name for customers account"
  type        = string
  default     = "customer"

}

/*variable "database_master_password" {
  description = "secrets"
  type        = string
  default     = "liqimm"
  sensitive   = true

}


variable "database_master_username" {
  description = "secrets"
  type        = string
  default     = ""
  sensitive   = true

}*/


variable "vpc_id" {
  description = "vpc id"
  type        = string
  default     = "vpc_id"
}


variable "subnet_id_rds_1a" {
  description = "subnet id1a"
  type        = string
  default     = "subnet_id_rds_1a"

}


variable "subnet_id_rds_1b" {
  description = "subnet id1b"
  type        = string
  default     = "subnet_id_rds_1b"

}


variable "list" {
  description = "db instance class"
  type        = string
  default     = "list"

}


variable "cidr_local" {
  description = "cidr_rds_1a"
  type        = string
  default     = "cidr_rds_1a"
}

