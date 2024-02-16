module "network" {
  source                = "./modules/network"
  project_name          = var.project_name
  vpc_cidr              = var.vpc_cidr
  public_subnets_number = var.public_subnets_number
  # public_subnet_az1_cidr = var.public_subnet_az1_cidr
  # public_subnet_az2_cidr = var.public_subnet_az2_cidr
  excluded_azs = var.excluded_azs
}

module "security" {
  source            = "./modules/security"
  cluster_role_name = var.cluster_role_name
  node_role_name    = var.node_role_name
  # cluster_role_arn  = var.cluster_role_arn
  # node_role_arn     = var.node_role_arn
}

module "eks" {
  source                  = "./modules/eks"
  cluster_name            = var.cluster_name
  cluster_policy          = module.security.cluster_policy
  node_policy_worker_node = module.security.node_policy_worker_node
  node_policy_ecr         = module.security.node_policy_ecr
  node_policy_cni         = module.security.node_policy_cni
  cluster_role_arn        = module.security.cluster_role_arn
  node_role_arn           = module.security.node_role_arn
  subnets                 = module.network.subnets
  # public_subnet_az1_id    = module.network.public_subnet_az1_id
  # public_subnet_az2_id    = module.network.public_subnet_az2_id
  ami_type       = var.ami_type
  capacity_type  = var.capacity_type
  disk_size      = var.disk_size
  instance_types = var.instance_types
}
