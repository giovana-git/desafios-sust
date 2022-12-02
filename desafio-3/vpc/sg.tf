resource "aws_security_group" "sg-terraform" {

  count  = 2
  name   = "sgterraform-${var.name_vpc[count.index]}"
  vpc_id = element(aws_vpc.vpc-terraform.*.id, count.index)

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [element(aws_vpc.vpc-terraform.*.cidr_block, count.index)]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "security-group-${var.name_vpc[count.index]}"
  }
}