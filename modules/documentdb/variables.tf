variable "name" {
  description = "name for customers account"
  type        = string
  default     = "bruno"

}


variable "subgroup" {
  description = "docdb subnet group name"
  type        = string
  default     = "subgroup"

}


variable "vpc_id" {
  description = "vpc id"
  type        = string
  default     = "vpc_id"

}


variable "list-docdb" {
  description = "db instance class"
  type        = string 
  default     = "list"

}


variable "subnet_id_docdb_1a" {
  description = "subnet docdb1a"
  type        = string
  default     = "subnet_id_docdb_1a"

}


variable "subnet_id_docdb_1b" {
  description = "subnet docdb1b"
  type        = string
  default     = "subnet_id_docdb_1b"

}