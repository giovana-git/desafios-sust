# resource "aws_eip" "eip-nat-gateway" {

#     count = 2
#   vpc = true

#   tags = {
#     Name = "eip-nat-gateway-${var.name_vpc[count.index]}"
#   }
# }

# resource "aws_nat_gateway" "nat-gateway-vpc1" {

#   depends_on = [
#     aws_eip.eip-nat-gateway
#   ]

#   count = 1

#   allocation_id = element(aws_eip.eip-nat-gateway.*.id, 0)
#   subnet_id     = element(aws_subnet.public-subnets-vpc1.*.id, count.index)

#   tags = {
#     Name = "nat-gateway-${var.name_vpc[0]}"
#   }
# }

# resource "aws_nat_gateway" "nat-gateway-cluster" {

#   depends_on = [
#     aws_eip.eip-nat-gateway
#   ]

#   count = 1

#   allocation_id = element(aws_eip.eip-nat-gateway.*.id, 1)
#   subnet_id     = element(aws_subnet.public-subnets-cluster.*.id, count.index)

#   tags = {
#     Name = "nat-gateway-${var.name_vpc[1]}"
#   }
# }

# resource "aws_route_table" "private-route-vpc1" {

#   count = 1
#   vpc_id = element(aws_vpc.vpc-terraform.*.id, 0)

#   tags = {
#     Name = "private-route-${var.name_vpc[0]}"
#   }
# }

# resource "aws_route_table" "private-route-cluster" {

#   count = 1
#   vpc_id = element(aws_vpc.vpc-terraform.*.id, 1)

#   tags = {
#     Name = "private-route-${var.name_vpc[1]}"
#   }
# }

# resource "aws_route" "private-vpc1" {

#   depends_on = [
#     aws_nat_gateway.nat-gateway-vpc1
#   ]

#     count = 1
#   route_table_id         = element(aws_route_table.private-route-vpc1.*.id, count.index)
#   destination_cidr_block = var.default_route_tables
#   nat_gateway_id         = element(aws_nat_gateway.nat-gateway-vpc1.*.id, count.index)
# }

# resource "aws_route" "private-cluster" {

#   depends_on = [
#     aws_nat_gateway.nat-gateway-cluster
#   ]

#     count = 1
#   route_table_id         = element(aws_route_table.private-route-cluster.*.id, count.index)
#   destination_cidr_block = var.default_route_tables
#   nat_gateway_id         = element(aws_nat_gateway.nat-gateway-cluster.*.id, count.index)
# }

# resource "aws_route_table_association" "ass-private-route-vpc1" {

#   depends_on = [
#     aws_subnet.private-subnets-vpc1,
#     aws_route_table.private-route-vpc1
#   ]

#   count          = length(var.private_subnets)
#   subnet_id      = element(aws_subnet.private-subnets-vpc1.*.id, count.index)
#   route_table_id = element(aws_route_table.private-route-vpc1.*.id, count.index)
# }

# resource "aws_route_table_association" "ass-private-route-cluster" {

#   depends_on = [
#     aws_subnet.private-subnets-cluster,
#     aws_route_table.private-route-cluster
#   ]

#   count          = length(var.private_subnets)
#   subnet_id      = element(aws_subnet.private-subnets-cluster.*.id, count.index)
#   route_table_id = element(aws_route_table.private-route-cluster.*.id, count.index)
# }