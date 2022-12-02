variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "tags" {
  type    = string
  default = "desafio1"
}

##############################

#####################################

variable "ami" {
  type    = string
  default = "ami-097a2df4ac947655f"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}