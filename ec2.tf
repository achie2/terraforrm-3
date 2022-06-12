# Creatiing ec2 instance

resource "aws_instance" "Test-server1" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.Test-sec-group.id]
  subnet_id                   = aws_subnet.Test-public-sub1.id
  availability_zone           = var.az1

  tags = {
    Name = "Test-server1"
  }
}

resource "aws_instance" "Test-server2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.Test-sec-group.id]
  subnet_id                   = aws_subnet.Test-public-sub2.id
  availability_zone           = var.az2

  tags = {
    Name = "Test-server2"
  }
}
