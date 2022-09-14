variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.76.160.0/20"

}

variable "name" {
  description = "name for customer's account"
  type        = string
  default     = "customer"

}

variable "list-rds" {
  description = "db instance class"
  type        = list(any)
  default     = ["db.t3.medium", "db.t3.large", "db.t3.xlarge", "db.m5.large", "db.m5.xlarge"]

}

variable "list-docdb" {
  description = "db instance class"
  type        = list(any)
  default     = ["db.t3.medium", "db.t3.large", "db.t3.xlarge", "db.m5.large", "db.m5.xlarge"]

}

variable "AMI" {
  description = "Sistema Operacional da instância"
  type        = map(any)
  default = {
    windows = "ami-041306c411c38a789"
    amazon  = "ami-0cff7528ff583bf9a"
    ubuntu  = "ami-052efd3df9dad4825"
    suse    = "ami-08895422b5f3aa64a"
    macos   = "ami-07a0f396e6eb97c9f"
  }
}

variable "INSTANCE_TYPE" {
  description = "Tipo da instância"
  type        = list(any)
  default     = ["t2.micro", "t2.medium", "t2.xlarge", "t3.micro", "t3.medium", "t3.xlarge", "m5.large", "m5.xlarge"]
}

variable "VOLUME_TYPE" {
  description = "Tipo do volume"
  type        = list(any)
  default     = ["standard", "gp2", "gp3", "io1", "io2", "sc1", "st1"]
}

variable "NAME" {
  description = "Nome do recurso"
  type        = string
  default     = "customer-prod"
}
