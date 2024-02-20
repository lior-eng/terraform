// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster
resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn ### should check

  vpc_config {
    # endpoint_private_access = false
    # endpoint_public_access  = true

    subnet_ids = var.subnets

  }
  depends_on = [
    var.cluster_policy
  ]
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "node_group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnets

  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 3
  }
  ami_type = var.ami_type

  capacity_type        = var.capacity_type
  disk_size            = var.disk_size
  force_update_version = false
  instance_types       = [var.instance_types]

  # labels = {    *** node labels
  #   "key" = "2"
  # }

  depends_on = [
    var.node_policy_worker_node,
    var.node_policy_ecr,
    var.node_policy_cni,
    var.node_policy_ebs
  ]
}

resource "aws_eks_addon" "addons" {
  for_each     = var.cluster_addons
  addon_name   = each.value
  cluster_name = aws_eks_cluster.cluster.name
  depends_on   = [aws_eks_node_group.node_group]
}