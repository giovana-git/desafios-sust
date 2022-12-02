resource "aws_internet_gateway" "igw-terraform-vpc1" {

  count  = 1
  vpc_id = element(aws_vpc.vpc-terraform.*.id, 0)

  tags = {
    Name = "igw-${var.name_vpc[0]}"
  }
}

resource "aws_internet_gateway" "igw-terraform-cluster" {

  count  = 1
  vpc_id = element(aws_vpc.vpc-terraform.*.id, 1)

  tags = {
    Name = "igw-${var.name_vpc[1]}"
  }
}

resource "aws_default_route_table" "public-vpc1" {

  depends_on = [
    aws_internet_gateway.igw-terraform-vpc1
  ]

  count                  = 1
  default_route_table_id = element(aws_vpc.vpc-terraform.*.default_route_table_id, 0)

  route {
    cidr_block = var.default_route_tables
    gateway_id = element(aws_internet_gateway.igw-terraform-vpc1.*.id, count.index)
  }

  tags = {
    Name = "public-route-${var.name_vpc[0]}"
  }
}

resource "aws_default_route_table" "public-cluster" {

  depends_on = [
    aws_internet_gateway.igw-terraform-cluster
  ]

  count                  = 1
  default_route_table_id = element(aws_vpc.vpc-terraform.*.default_route_table_id, 1)

  route {
    cidr_block = var.default_route_tables
    gateway_id = element(aws_internet_gateway.igw-terraform-cluster.*.id, count.index)
  }

  tags = {
    Name = "public-route-${var.name_vpc[1]}"
  }
}

resource "aws_route_table_association" "ass-public-route-vpc1" {

  depends_on = [
    aws_default_route_table.public-vpc1
  ]

  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public-subnets-vpc1.*.id, count.index)
  route_table_id = element(aws_default_route_table.public-vpc1.*.id, count.index)
}

resource "aws_route_table_association" "ass-public-route-cluster" {

  depends_on = [
    aws_default_route_table.public-cluster
  ]

  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public-subnets-cluster.*.id, count.index)
  route_table_id = element(aws_default_route_table.public-cluster.*.id, count.index)
}