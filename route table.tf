resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "demo-public-rt"
  }
}

resource "aws_route_table_association" "public-as" {
  subnet_id      = aws_subnet.public-1a.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "public-as1" {
  subnet_id      = aws_subnet.public-1b.id
  route_table_id = aws_route_table.public-rt.id
}
