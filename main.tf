resource "aws_vpc" "prashansa_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "prashansa_vpc"
  }
}
resource "aws_subnet" "prashansa_publicSubnet1" {
  vpc_id            = aws_vpc.prashansa_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    "Name"        = "prashansa_publicSubnet1"
    "silo"        = "intern2"
    "environment" = "dev"
    "owner"       = "prashansa.joshi"
  }
}
resource "aws_subnet" "prashansa_publicSubnet2" {
  vpc_id            = aws_vpc.prashansa_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    "Name"        = "prashansa_publicSubnet2"
    "silo"        = "intern2"
    "environment" = "dev"
    "owner"       = "prashansa.joshi"
  }
}
resource "aws_subnet" "prashansa_privateSubnet1" {
  vpc_id            = aws_vpc.prashansa_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    "Name"        = "prashansa_privateSubnet1"
    "silo"        = "intern2"
    "environment" = "dev"
    "owner"       = "prashansa.joshi"
  }
}
resource "aws_subnet" "prashansa_privateSubnet2" {
  vpc_id            = aws_vpc.prashansa_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    "Name"        = "prashansa_privateSubnet2"
    "silo"        = "intern2"
    "environment" = "dev"
    "owner"       = "prashansa.joshi"
  }
}
resource "aws_internet_gateway" "igw_terraform_prashansa" {
  vpc_id = aws_vpc.prashansa_vpc.id
}
resource "aws_route_table" "RT_public_terraform_prashansa" {
  vpc_id = aws_vpc.prashansa_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_terraform_prashansa.id
  }
}
resource "aws_route_table" "RT_private_terraform_prashansa" {
  vpc_id = aws_vpc.prashansa_vpc.id
}
resource "aws_route_table_association" "RT_public_terraform_prashansa_Association" {
  subnet_id      = aws_subnet.prashansa_publicSubnet1.id
  route_table_id = aws_route_table.RT_public_terraform_prashansa.id
}

resource "aws_route_table_association" "RT_public_terraform_prashansa_Association2" {
  subnet_id      = aws_subnet.prashansa_publicSubnet2.id
  route_table_id = aws_route_table.RT_public_terraform_prashansa.id
}