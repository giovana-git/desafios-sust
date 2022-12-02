resource "aws_subnet" "public-subnets-vpc1" {

  count                   = 2
  vpc_id                  = element(aws_vpc.vpc-terraform.*.id, 0)
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name       = "public-subnet-${var.name_vpc[0]}"
    Enviroment = "public-subnet-${(var.azs[count.index])}"
  }
}

resource "aws_subnet" "public-subnets-cluster" {

  count                   = 2
  vpc_id                  = element(aws_vpc.vpc-terraform.*.id, 1)
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name       = "public-subnet-${var.name_vpc[1]}"
    Enviroment = "public-subnet-${(var.azs[count.index])}"
  }
}

resource "aws_subnet" "private-subnets-vpc1" {

  count                   = 2
  vpc_id                  = element(aws_vpc.vpc-terraform.*.id, 0)
  cidr_block              = var.private_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name       = "private-subnet-${var.name_vpc[0]}"
    Enviroment = "private-subnet-${(var.azs[count.index])}"
  }
}

resource "aws_subnet" "private-subnets-cluster" {

  count                   = 2
  vpc_id                  = element(aws_vpc.vpc-terraform.*.id, 1)
  cidr_block              = var.private_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name       = "private-subnet-${var.name_vpc[1]}"
    Enviroment = "private-subnet-${(var.azs[count.index])}"
  }
}