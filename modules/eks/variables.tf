variable "cluster_name" {
  type = string
}

variable "cluster_policy" {}

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

variable "node_policy_worker_node" {}

variable "node_policy_ecr" {}

variable "node_policy_cni" {}

variable "node_policy_ebs" {}

variable "cluster_role_arn" {
  type = string
}

variable "node_role_arn" {
  type = string
}

variable "public_subnets" {
  type        = list(string)
  description = "public subnets id"
}

variable "private_subnets" {
  type        = list(string)
  description = "private subnets id"
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

variable "cluster_addons" {
  description = "Names of eks add-on to grant the cluster"
  type        = set(string)
  default     = ["kube-proxy", "vpc-cni", "coredns", "aws-ebs-csi-driver"]  
} //aws-ebs-csi-driver is creating the storage class is needed for pvc and pv.