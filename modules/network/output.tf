output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "igw" {
  value = aws_internet_gateway.igw
}

output "subnets" {
  value = aws_subnet.public_subnets[*].id
}
