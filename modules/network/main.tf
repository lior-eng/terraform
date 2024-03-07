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
  map_public_ip_on_launch = var.public_ip_on_launch

  tags = {
    Name = "public_subnet_${terraform.workspace}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public route table"
  }
}

resource "aws_route_table_association" "public_subnets_route_table_association" {
  count          = var.public_subnets_number
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}
