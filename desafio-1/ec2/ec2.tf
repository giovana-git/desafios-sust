resource "aws_instance" "ec2-terraform" {

  ami                         = var.ami
  vpc_security_group_ids      = ["sg-017bb1653c38652ec"]
  instance_type               = var.instance_type
  subnet_id                   = "subnet-007ec87507a616a08"
  key_name                    = "key-desafio-1"
  associate_public_ip_address = true

  tags = {
    Name = "servidor-${var.tags}"
  }
}

#############################################


resource "aws_eip" "eip-instancia" {
  instance = aws_instance.ec2-terraform.id
  vpc      = true
}
