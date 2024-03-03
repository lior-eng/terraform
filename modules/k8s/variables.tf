variable "repository_url" {
  type = string
}

variable "parent-application" {
  type        = string
  description = "Path to parent application file"
}
###
variable "region" {
  type        = string
  description = "AWS region"
}

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
