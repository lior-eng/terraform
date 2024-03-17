output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "igw" {
  value = aws_internet_gateway.igw
}

output "public_subnets" {
  value = aws_subnet.public_subnets[*].id
}

output "private_subnets" {
  value = aws_subnet.private_subnets[*].id
}