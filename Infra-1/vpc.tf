resource "aws_vpc" "nginx-demo" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "nginx-demo"
  }

}

resource "aws_subnet" "public-subnet-1" {
  vpc_id = aws_vpc.nginx-demo.id
  cidr_block = "10.0.1.0/24"
  availability_zone = us-east-1a
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2"{
    vpc_id = aws_vpc.nginx-demo.id
    cidr_block = "10.0.2.0/24"
    availability_zone = us-east-1b
    tags={
        Name="public-subnet-2"
    }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id = aws_vpc.nginx-demo.id
  cidr_block = "10.0.3.0/24"
  availability_zone = us-east-1a
  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id = aws_vpc.nginx-demo.id
  cidr_block = "10.0.4.0/24"
  availability_zone = us-east-1b
  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_internet_gateway" "nginx-igw" {
  vpc_id = aws_vpc.nginx-demo.id
  tags = {
    Name = "nginx-igw"
  }

}

resource "aws_eip" "nginx-eip" {
   vpc = true
}

resource "aws_nat_gateway" "nginx-ngw" {
  allocation_id = aws_eip.nginx-eip.id
  subnet_id = aws_subnet.public-subnet-1.id

  tags = {
    Name = "nginx-ngw"
  }
  
}

resource "aws_route_table" "nginx-public-route-tb" {
  vpc_id = aws_vpc.nginx-demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nginx-igw.id
  }

  tags = {
    Name = nginx-public-route-tb
  }

}

resource "aws_route_table" "nginx-private-route-tb" {
  vpc_id = aws_vpc.nginx-demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id =  aws_nat_gateway.nginx-ngw.id
  }

  tags = {
    Name = "nginx-private-route-tb"
  }
}

resource "aws_route_table_association" "public-subnet-association-1" {
  subnet_id = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.nginx-public-route-tb.id
}

resource "aws_route_table_association" "public-subnet-association-2" {
  subnet_id = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.nginx-public-route-tb.id
}

resource "aws_route_table_association" "private-subnet-association-1" {
  subnet_id = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.nginx-private-route-tb.id
}

resource "aws_route_table_association" "private-subnet-association-2" {
   subnet_id = aws_subnet.private-subnet-2.id
   route_table_id = aws_route_table.nginx-private-route-tb.id
}
}