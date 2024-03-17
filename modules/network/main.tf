resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# data source to get all az in region
data "aws_availability_zones" "available_zones" {
  state         = "available"
  exclude_names = var.excluded_azs
}

locals {
  azs = data.aws_availability_zones.available_zones.names
}

resource "aws_subnet" "public_subnets" {
  count                   = var.public_subnets_number
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index)
  availability_zone       = element(local.azs, count.index)
  map_public_ip_on_launch = var.public_ip_on_launch // eks requirement 

  tags = {
    Name = "public_subnet_${terraform.workspace}_${count.index}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_route_table_${terraform.workspace}"
  }
}

resource "aws_route_table_association" "public_subnets_route_table_association" {
  count          = var.public_subnets_number
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

######################## private subnets ########################

resource "aws_subnet" "private_subnets" {
  count                   = var.private_subnets_number // add var
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index + var.public_subnets_number)
  availability_zone       = element(local.azs, count.index)
  map_public_ip_on_launch = var.private_ip_on_launch // eks requirement 

  tags = {
    Name = "private_subnet_${terraform.workspace}_${count.index}"
  }
}

resource "aws_eip" "nat_eip" {
  count      = var.public_subnets_number
  # vpc        = true // deprecated?? 
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "ngw" {
  count         = var.public_subnets_number
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id

  tags = {
    Name = "nat_gateway_${terraform.workspace}_${count.index}"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw[0].id // index 0 because NAT is a list
  }

  tags = {
    Name = "private_route_table_${terraform.workspace}"
  }
}

resource "aws_route_table_association" "private_subnets_route_table_association" {
  count          = var.private_subnets_number
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}
