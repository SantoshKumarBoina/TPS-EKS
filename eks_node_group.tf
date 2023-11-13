resource "aws_eks_node_group" "node-grp" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.worker.arn
  subnet_ids      = var.subnet_ids
  capacity_type   = "ON_DEMAND"
  disk_size       = "20"
  instance_types  = var.worker_instance_types

  remote_access {
    ec2_ssh_key   = var.key_pair
    source_security_group_ids = [aws_security_group.allow_tls.id]
  }


  scaling_config {
    desired_size = var.worker_desired_size
    max_size     = var.worker_max_size
    min_size     = var.worker_min_size
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}