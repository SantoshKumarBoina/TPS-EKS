resource "aws_eks_cluster" "eks" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.master.arn
  version  = "1.28" 


  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [aws_security_group.allow_tls.id]

    endpoint_private_access = var.endpoint_private_access 
    endpoint_public_access  = var.endpoint_public_access  

  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]

}