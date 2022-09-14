variable "vpc_id" {
  description = "vpc id"
  type        = string
  default     = "vpc_id"

}


variable "gateway_id" {
  description = "gateway_id"
  type        = string
  default     = "gateway_id"

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

variable "subnet_id_rds_1a" {
  description = "subnet id1b"
  type        = string
  default     = "subnet_id_rds_1a"

}

variable "subnet_id_rds_1b" {
  description = "subnet id1b"
  type        = string
  default     = "subnet_id_rds_1b"

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


variable "subnet_id_pub1a" {
  description = "subnet id1b"
  type        = string
  default     = "subnet_id_pub1a"

}

variable "subnet_id_pub1b" {
  description = "subnet id1b"
  type        = string
  default     = "liqi-market-maker-prod"

}
