output "eks_cluster_id" {
  value = aws_eks_cluster.eks.id
}

output "eks_master_role_arn" {
  value = aws_iam_role.master.arn
}

output "eks_worker_role_arn" {
  value = aws_iam_role.worker.arn
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "eks_cluster_certificate_authority_data" {
  value = aws_eks_cluster.eks.certificate_authority.0.data
}

output "eks_cluster_security_group_ids" {
  value = aws_eks_cluster.eks.vpc_config[0].security_group_ids
}

output "eks_node_group_instance_profile" {
  value = aws_eks_node_group.node-grp.instance_profile_name
}

output "eks_node_group_desired_capacity" {
  value = aws_eks_node_group.node-grp.desired_capacity
}

output "eks_node_group_max_capacity" {
  value = aws_eks_node_group.node-grp.max_capacity
}

output "eks_node_group_min_capacity" {
  value = aws_eks_node_group.node-grp.min_capacity
}

output "eks_node_group_subnet_ids" {
  value = aws_eks_node_group.node-grp.subnet_ids
}

output "eks_cluster_kubectl_config" {
  value = aws_eks_cluster.eks.kubeconfig.0.id
}

