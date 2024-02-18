output "cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "node_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}

output "cluster_policy" {
  value = aws_iam_role_policy_attachment.amazonaws_eks_cluster_policy_attachment
}

output "node_policy_worker_node" {
  value = aws_iam_role_policy_attachment.amazonaws_eks_worker_node_policy_attachment
}

output "node_policy_ecr" {
  value = aws_iam_role_policy_attachment.amazonaws_ecr_policy_attachment
}

output "node_policy_cni" {
  value = aws_iam_role_policy_attachment.amazonaws_eks_cni_policy_attachment
}

output "node_policy_ebs" {
  value = aws_iam_role_policy_attachment.eks_nodes_ebs_access
}
