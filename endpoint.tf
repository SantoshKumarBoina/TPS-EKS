resource "aws_vpc_endpoint" "eks_api_endpoint" {
vpc_id = var.vpc_id
service_name = "com.amazonaws.${var.aws_region}.eks"
private_dns_enabled = true
security_group_ids = [aws_security_group.allow_tls.id]
vpc_endpoint_type = "Interface"
subnet_ids = var.subnet_ids


tags = {
    Name  = "MyVpcEndpoint"
}
}