resource "aws_subnet" "subnets-database-vpc1" {

  count                   = 2
  vpc_id                  = element(aws_vpc.vpc-terraform.*.id, 0)
  cidr_block              = var.database_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name       = "database-subnet-${var.name_vpc[0]}"
    Enviroment = "database-subnet-${var.azs[count.index]}"
  }
}

resource "aws_subnet" "subnets-database-cluster" {

  count                   = 2
  vpc_id                  = element(aws_vpc.vpc-terraform.*.id, 1)
  cidr_block              = var.database_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name       = "database-subnet-${var.name_vpc[1]}"
    Enviroment = "database-subnet-${var.azs[count.index]}"
  }
}