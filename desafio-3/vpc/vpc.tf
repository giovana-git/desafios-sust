resource "aws_vpc" "vpc-terraform" {

  count                = 2
  cidr_block           = var.cidr
  enable_dns_support   = var.dns_support
  enable_dns_hostnames = var.dns_hostnames

  tags = {
    Name = "${(var.name_vpc[count.index])}"
  }
}