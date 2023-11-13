resource "aws_eks_addon" "cni" {
cluster_name =  aws_eks_cluster.eks.name
addon_name = "vpc-cni"
addon_version = var.cni_addon_version
resolve_conflicts_on_create = "OVERWRITE" 
resolve_conflicts_on_update = "OVERWRITE" 
service_account_role_arn = var.cni_service_account_role_arn

}

resource "aws_eks_addon" "core_dns" {
cluster_name = aws_eks_cluster.eks.name
addon_name = "coredns"
addon_version = var.core_dns_addon_version
resolve_conflicts_on_create = "OVERWRITE"
resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_addon" "kube_proxy" {
cluster_name = aws_eks_cluster.eks.name
addon_name = "kube-proxy"
addon_version = var.kube_proxy_addon_version
resolve_conflicts_on_create = "OVERWRITE" 
resolve_conflicts_on_update = "OVERWRITE"

}