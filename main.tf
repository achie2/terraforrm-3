# Creating networking for the project


resource "aws_vpc" "prod-rock-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "prod-rock-vpc"
  }
}


# Public Subnet 1 


resource "aws_subnet" "Test-public-sub1" {
  vpc_id            = aws_vpc.prod-rock-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"



  tags = {
    Name = "Test-public-sub1"
  }
}


# Public Subnet 2


resource "aws_subnet" "Test-public-sub2" {
  vpc_id            = aws_vpc.prod-rock-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-2b"



  tags = {
    Name = "Test-public-sub2"
  }
}




# Private Subnet 1


resource "aws_subnet" "Test-priv-sub1" {
  vpc_id            = aws_vpc.prod-rock-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-2a"



  tags = {
    Name = "Test-priv-sub1"
  }
}


# Private Subnet 2


resource "aws_subnet" "Test-priv-sub2" {
  vpc_id            = aws_vpc.prod-rock-vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "eu-west-2b"



  tags = {
    Name = "Test-priv-sub2"
  }
}


# Public route table

resource "aws_route_table" "Test-pub-route-table" {
  vpc_id = aws_vpc.prod-rock-vpc.id



  tags = {
    Name = "Test-pub-route-table"
  }
}


# Private route table

resource "aws_route_table" "Test-priv-route-table" {
  vpc_id = aws_vpc.prod-rock-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.Test_Nat_gateway.id
  }



  tags = {
    Name = "Test-priv-route-table"
  }
}


# Associate public subnets with the public route table


resource "aws_route_table_association" "Test-public-sub1_route_assoc" {
  subnet_id      = aws_subnet.Test-public-sub1.id
  route_table_id = aws_route_table.Test-pub-route-table.id
}

resource "aws_route_table_association" "Test-public-sub2_route_assoc" {
  subnet_id      = aws_subnet.Test-public-sub2.id
  route_table_id = aws_route_table.Test-pub-route-table.id
}



# Associate private subnets with the private route table

resource "aws_route_table_association" "Test-priv-route-table_route_assoc" {
  subnet_id      = aws_subnet.Test-priv-sub1.id
  route_table_id = aws_route_table.Test-priv-route-table.id
}


resource "aws_route_table_association" "priv_sub2_route_assoc" {
  subnet_id      = aws_subnet.Test-priv-sub2.id
  route_table_id = aws_route_table.Test-priv-route-table.id
}

# Internet Gateway

resource "aws_internet_gateway" "Test-igw" {
  vpc_id = aws_vpc.prod-rock-vpc.id


  tags = {
    Name = "Test-igw"
  }
}

# Associate the internet gateway to the public route table

resource "aws_route" "Test-igw-association" {
  route_table_id         = aws_route_table.Test-pub-route-table.id
  gateway_id             = aws_internet_gateway.Test-igw.id
  destination_cidr_block = "0.0.0.0/0"
}


# Allocate elastic ip address for the Nat gateway

resource "aws_eip" "eip_for_nat_gateway" {
  vpc = true
  tags = {
    Name = "eip-for-nat-gateway"
  }
}


# Creating Nat gateway

resource "aws_nat_gateway" "Test_Nat_gateway" {
  allocation_id = aws_eip.eip_for_nat_gateway.id
  subnet_id     = aws_subnet.Test-public-sub1.id

  tags = {
    Name = "Test-Nat-gateway"
  }

}






#Put Apache web server on the Ubuntu server in the public subnet. Use Ansible to install Apache on the Ubuntu server.
#NB:
#Check the Ansible notes, you will find useful information that will help you.
#Make your codes reusable by creating a variable file.
#Once done please push your codes to GitHub. And send the link.

 