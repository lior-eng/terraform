output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "igw" {
  value = aws_internet_gateway.igw
}

# output "public_subnets_number" {
#   value = aws_subnet.public_subnets
# }

output "subnets" {
  value = aws_subnet.public_subnets[*].id
}
# output "public_subnet_az1_id" {
#   value = aws_subnet.public_subnet_az1.id
# }

# output "public_subnet_az2_id" {
#   value = aws_subnet.public_subnet_az2.id
# }
