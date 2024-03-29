################ general ################
variable "profile" {
  type        = string
  default     = "default"
  description = "configuration and credential profile on local machine"
}

variable "common_tags" {
  default = {
    Owner           = "liorl"
    Bootcamp        = "19"
    expiration_date = "2026-01-01"
  }
}

variable "region" {
  type        = string
  description = "AWS region"
}

################ network ################
variable "project_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnets_number" {
  type        = number
  default     = 2
  description = "number of subnets in VPC"
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

################ security ################
variable "cluster_role_name" {
  type = string
}

variable "node_role_name" {
  type = string
}

################ eks ################
variable "cluster_name" {
  type = string
}

variable "node_group_desired_size" {
  type        = number
  default     = 2
  description = "number of desired nodes"
}

variable "node_group_max_size" {
  type        = number
  default     = 2
  description = "number of max nodes"
}

variable "node_group_min_size" {
  type        = number
  default     = 2
  description = "number of min nodes"
}

variable "ami_type" {
  type    = string
  default = "AL2_x86_64"
}

variable "capacity_type" {
  type        = string
  default     = "ON_DEMAND"
  description = "can check SPOT also for cheaper price, but aws can take it any time!!"
}

variable "disk_size" {
  type        = number
  default     = 20
  description = "size in GiB"
}

variable "instance_types" {
  type    = string
  default = "t3a.large"
}

################ k8s ################
variable "repository_url" {
  type = string
}

## region declared above in general section 

variable "account_id" {
  type        = string
  description = "AWS Account ID"
}

variable "postgres_db_secret_name" {
  type        = string
  description = "Name of the secret in AWS Secrets Manager"
}

variable "argocd_ssh_secret_name" {
  type        = string
  description = "Name of the secret in AWS Secrets Manager"
}

variable "ecr_credentials_secret_name" {
  type        = string
  description = "Name of the secret in AWS Secrets Manager"
}