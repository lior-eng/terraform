variable "project_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnets_number" {
  type        = number
  default     = 2
  description = "number of public subnets in VPC"
}

variable "excluded_azs" {
  description = "Avaliability zones to ignore (e.g. use1-az3 can't reside eks subnets)"
  type        = list(string)
  default     = ["use1-az3", "usw1-az2", "cac1-az3"]
}

variable "public_ip_on_launch" {
  type        = bool
  default     = true
  description = "public IP for ec2"
}

variable "private_subnets_number" {
  type        = number
  default     = 2
  description = "number of private subnets in VPC"
}

variable "private_ip_on_launch" {
  type        = bool
  default     = false
  description = "public IP for ec2"
}
