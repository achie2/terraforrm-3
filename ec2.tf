# Creatiing ec2 instance

resource "aws_instance" "Test-server1" {
  ami                         = "ami-0758d98b134137d18"
  instance_type               = "t2.micro"
  key_name                    = "kayden"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.Test-sec-group.id]
  subnet_id                   = aws_subnet.Test-public-sub1.id
  availability_zone           = "eu-west-2a"

  tags = {
    Name = "Test-server1"
  }
}

resource "aws_instance" "Test-server2" {
  ami                         = "ami-0758d98b134137d18"
  instance_type               = "t2.micro"
  key_name                    = "kayden"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.Test-sec-group.id]
  subnet_id                   = aws_subnet.Test-public-sub2.id
  availability_zone           = "eu-west-2b"

  tags = {
    Name = "Test-server2"
  }
}
