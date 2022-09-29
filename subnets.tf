resource "aws_subnet" "public-1a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  enable_resource_name_dns_a_record_on_launch = "true"
  map_public_ip_on_launch  = "true"
  tags = {
    Name = "demo-public-subnet-1a"
    terrformed = "true"
  }
}

resource "aws_subnet" "public-1b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  enable_resource_name_dns_a_record_on_launch = "true"
  map_public_ip_on_launch  = "true"
  tags = {
    Name = "demo-public-subnet-1b"
    teraformed = "true"
  }
}
