variable "vpc_id" {
  description = "ID of the VPC where the EKS cluster will be deployed."
  type        = string
  default = "vpc-0b416c1836203d49b"
}
variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster. Should be in at least two Availability Zones."
  type        = list(string)
  default = [ "subnet-08cc8ac2ec214e126", "subnet-022e2a3c06aebd3f5" ]
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  default     = "tps-eks"
}

variable "eks_master_role_name" {
  description = "Name of the EKS master role"
  default     = "tps-eks-master"
}

variable "eks_worker_role_name" {
  description = "Name of the EKS worker role"
  default     = "tps-eks-worker"
}



variable "node_group_name" {
  description = "Name of the EKS node group"
  default     = "tps-node-group"
}



variable "worker_desired_size" {
  description = "Desired size of the worker node group"
  default     = 2
}

variable "worker_max_size" {
  description = "Maximum size of the worker node group"
  default     = 3
}

variable "worker_min_size" {
  description = "Minimum size of the worker node group"
  default     = 1
}

variable "worker_disk_size" {
  description = "Size of the worker node disk"
  default     = "20"
}

variable "worker_instance_types" {
  description = "List of instance types for worker nodes"
  default     = ["t2.small"]
}

variable "key_pair" {
  description = "Name of the SSH key pair for accessing the EKS nodes."
  type        = string
  default = "keys"
}


variable "endpoint_private_access" {
  description = "List of private CIDR blocks for EKS cluster access"
  type        = bool
  default     = true
  
}

variable "endpoint_public_access" {
  description = "List of private CIDR blocks for EKS cluster access"
  type        = bool
  default     = false
  
}

variable "ami_id" {
  description = "ID of the Amazon Machine Image to use for kubectl instance"
  type        = string
  default   = "ami-075b165b55797e19d" 
  
}

variable "instance_type" {
  description = "The type of instance to launch"
  type        = string
  default     = "t2.micro"
  
}

variable "pub_subnet_id" {
  description = "Subnet ID for kubectl instance"
  type        = string 
  default     = "subnet-08cc8ac2ec214e126"
  
}

variable "aws_region" {
  description = "AWS region where we want to create our cluster"
  type        = string
  default    = "eu-west-2" 
  
}


variable "cni_addon_version" {
  description = "Version of the VPC CNI addon"
  type        = string
  default     = "v1.15.3-eksbuild.1"
}

variable "core_dns_addon_version" {
  description = "Version of the CoreDNS addon"
  type        = string
  default     = "v1.9.11-eksbuild.3"
}

variable "kube_proxy_addon_version" {
  description = "Version of the kube-proxy addon"
  type        = string
  default     = "v1.28.2-eksbuild.2"
}

variable "cni_service_account_role_arn" {
  description = "ARN of the IAM role for the VPC CNI addon"
  type        = string
}