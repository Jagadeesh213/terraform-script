#elastic-ips

resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.igw]
  vpc      = true
  tags = {
    name = "natgate eip"
  }
}

#nategates

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public-1a.id

  tags = {
    Name = "demo nat"
  }
}

resource "aws_nat_gateway" "ngw1" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public-1b.id

  tags = {
    Name = "demo nat1"
  }
}

#private-subnets

resource "aws_subnet" "pvt-sub-1a" {
  vpc_id     = aws_vpc.sample.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "pvt-subnet-1a"
  }
}

resource "aws_subnet" "pvt-sub-1b" {
  vpc_id     = aws_vpc.sample.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "pvt-subnet-1b"
  }
}

#private-routetable

resource "aws_route_table" "pvt-rt-1a" {
  vpc_id = aws_vpc.sample.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }
  tags = {
    Name = "demo-pvt-rt-1a"
  }
}

resource "aws_route_table" "pvt-rt-1b" {
  vpc_id = aws_vpc.sample.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw1.id
  }
  tags = {
    Name = "demo-pvt-rt-1b"
  }
}

#private-route-associations

resource "aws_route_table_association" "pvt-as" {
  subnet_id      = aws_subnet.pvt-sub-1a.id
  route_table_id = aws_route_table.pvt-rt-1a.id
}

resource "aws_route_table_association" "pvt-as1" {
  subnet_id      = aws_subnet.pvt-sub-1b.id
  route_table_id = aws_route_table.pvt-rt-1b.id
}
