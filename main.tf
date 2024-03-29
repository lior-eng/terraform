module "network" {
  source                = "./modules/network"
  project_name          = var.project_name
  vpc_cidr              = var.vpc_cidr
  public_subnets_number = var.public_subnets_number
  excluded_azs          = var.excluded_azs
  public_ip_on_launch   = var.public_ip_on_launch
  #########
  private_subnets_number = var.private_subnets_number
  private_ip_on_launch   = var.private_ip_on_launch
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
  node_group_desired_size = var.node_group_desired_size
  node_group_max_size     = var.node_group_max_size
  node_group_min_size     = var.node_group_min_size
  node_policy_worker_node = module.security.node_policy_worker_node
  node_policy_ecr         = module.security.node_policy_ecr
  node_policy_cni         = module.security.node_policy_cni
  node_policy_ebs         = module.security.node_policy_ebs
  cluster_role_arn        = module.security.cluster_role_arn
  node_role_arn           = module.security.node_role_arn
  public_subnets          = module.network.public_subnets  //new
  private_subnets         = module.network.private_subnets //new
  ami_type                = var.ami_type
  capacity_type           = var.capacity_type
  disk_size               = var.disk_size
  instance_types          = var.instance_types
}

module "k8s" {
  source                      = "./modules/k8s"
  repository_url              = var.repository_url
  parent-application          = "${path.module}/manifests/parent-application.yaml"
  region                      = var.region
  account_id                  = var.account_id
  postgres_db_secret_name     = var.postgres_db_secret_name
  argocd_ssh_secret_name      = var.argocd_ssh_secret_name
  ecr_credentials_secret_name = var.ecr_credentials_secret_name
}
