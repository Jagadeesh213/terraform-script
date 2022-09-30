provider "aws" {
  access_key =  "your access_keys"
  secret_key = "your secret_keys"
  region = "us-east-1"
}

#VPC

resource "aws_vpc" "sample" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "demo-vpc"
    terraformed = "true"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.sample.id

  tags = {
    Name = "demo-igw"
    terrformed = "true"
  }
}

#public-subnets

resource "aws_subnet" "public-1a" {
  vpc_id     = aws_vpc.sample.id
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
  vpc_id     = aws_vpc.sample.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  enable_resource_name_dns_a_record_on_launch = "true"
  map_public_ip_on_launch  = "true"
  tags = {
    Name = "demo-public-subnet-1b"
    teraformed = "true"
  }
}

#public-routetable

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.sample.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "demo-public-rt"
  }
}

#route-association

resource "aws_route_table_association" "public-as" {
  subnet_id      = aws_subnet.public-1a.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "public-as1" {
  subnet_id      = aws_subnet.public-1b.id
  route_table_id = aws_route_table.public-rt.id
}
