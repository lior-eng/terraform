module "network" {
  source                = "./modules/network"
  project_name          = var.project_name
  vpc_cidr              = var.vpc_cidr
  public_subnets_number = var.public_subnets_number
  excluded_azs          = var.excluded_azs
}

module "security" {
  source            = "./modules/security"
  cluster_role_name = var.cluster_role_name
  node_role_name    = var.node_role_name
}

module "eks" {
  source                  = "./modules/eks"
  cluster_name            = var.cluster_name
  cluster_policy          = module.security.cluster_policy
  node_policy_worker_node = module.security.node_policy_worker_node
  node_policy_ecr         = module.security.node_policy_ecr
  node_policy_cni         = module.security.node_policy_cni
  node_policy_ebs         = module.security.node_policy_ebs
  cluster_role_arn        = module.security.cluster_role_arn
  node_role_arn           = module.security.node_role_arn
  subnets                 = module.network.subnets
  ami_type                = var.ami_type
  capacity_type           = var.capacity_type
  disk_size               = var.disk_size
  instance_types          = var.instance_types
}

module "k8s" {
  source = "./modules/k8s"
  repository_url = var.repository_url
  main_app_path = "${path.module}/manifests/main_app_path.yaml"
}
