variable "cluster_name" {
  type = string
}

variable "cluster_policy" {
  # type = string
}

variable "node_policy_worker_node" {
  # type = string
}

variable "node_policy_ecr" {
  # type = string
}

variable "node_policy_cni" {
  # type = string
}

variable "cluster_role_arn" {
  type = string
}

variable "node_role_arn" {
  type = string
}

variable "subnets" {
  type        = list(string)
  description = "subnets id"
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
  default = "t3a.medium"
}

variable "cluster_addons" {
  description = "Names of eks add-on to grant the cluster"
  type        = set(string)
  default     = ["kube-proxy", "vpc-cni", "coredns", "aws-ebs-csi-driver"]
}