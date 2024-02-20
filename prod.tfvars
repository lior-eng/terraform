################ general ################
region = "us-east-1"

################ network ################
# region                 = "us-east-1"
project_name           = "protfolio"
vpc_cidr               = "10.0.0.0/16"
public_subnet_az1_cidr = "10.0.0.0/24"
public_subnet_az2_cidr = "10.0.1.0/24"
excluded_azs           = ["use1-az3", "usw1-az2", "cac1-az3"]

################ security ################
cluster_role_name = "lior-levi-eks_cluster_role"
node_role_name    = "lior-levi-eks_node_role"

############### eks ################
cluster_name = "commercial-store"

############### k8s ################
repository_url = "git@github.com:lior-eng/gitops.git"