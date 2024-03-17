################ general ################
region = "us-east-1"

################ network ################
## region declared above in general section
project_name           = "protfolio"
vpc_cidr               = "10.0.0.0/16"
excluded_azs           = ["use1-az3", "usw1-az2", "cac1-az3"]

################ security ################
cluster_role_name = "lior-levi-eks_cluster_role"
node_role_name    = "lior-levi-eks_node_role"

############### eks ################
cluster_name = "commercial-store"

############### k8s ################
repository_url          = "git@github.com:lior-eng/gitops.git"
## region declared above in general section
account_id              = "644435390668"
postgres_db_secret_name = "postgres-secret-UWgQIy"
argocd_ssh_secret_name  = "argocd-key-FmBgGN"
