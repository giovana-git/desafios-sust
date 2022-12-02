variable "name" {
  type    = string
  default = "desafio3"
}

variable "name_vpc" {
  type    = list(string)
  default = ["vpc-1", "vpc-cluster"]
}

variable "cidr" {
  type    = string
  default = "192.168.0.0/16"
}

variable "dns_support" {
  type    = string
  default = "true"
}

variable "dns_hostnames" {
  type    = string
  default = "true"
}

variable "private_subnets" {
  type    = list(string)
  default = ["192.168.1.0/24", "192.168.2.0/24"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["192.168.3.0/24", "192.168.4.0/24"]
}

variable "database_subnets" {
  type    = list(string)
  default = ["192.168.5.0/24", "192.168.6.0/24"]
}

variable "azs" {
  type    = list(string)
  default = ["us-east-2a", "us-east-2b"]
}

variable "default_route_tables" {
  type    = string
  default = "0.0.0.0/0"
}

