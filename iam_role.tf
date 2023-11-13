resource "aws_iam_role" "master" {
  name = var.eks_master_role_name

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.master.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.master.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.master.name
}

resource "aws_iam_role" "worker" {
  name = var.eks_worker_role_name

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "autoscaler" {
  name   = "ed-eks-autoscaler-policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeTags",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup",
        "ec2:DescribeLaunchTemplateVersions"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.worker.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.worker.name
}


resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.worker.name
}



resource "aws_iam_role_policy_attachment" "autoscaler" {
  policy_arn = aws_iam_policy.autoscaler.arn
  role       = aws_iam_role.worker.name
}



resource "aws_iam_role" "cni_role" {
  name = "eks-cni-role"
  assume_role_policy = jsonencode({ 
    Version = "2012-10-17"
    Statement = [
       { 
        Action = "sts:AssumeRole",
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]   
  })
}  

resource "aws_iam_policy" "cni_policy" {
name= "eks-cni-policy" 
description = "Policy for Amazon VPC CNI Plugin"
policy = jsonencode({
  Version = "2012-10-17" 
  Statement = [
    {
      Action = [
              "ec2: AssignPrivateIpAddresses",
              "ec2: AttachNetworkInterface",
              "ec2:CreateNetworkInterface", 
              "ec2: DeleteNetworkInterface",
              "ec2: Describe Instances",
              "ec2: DescribeTags",
              "ec2: DescribeNetworkInterfaces",
              "ec2: Describe InstanceTypes",
              "ec2: DetachNetwork Interface",
              "ec2:ModifyNetwork InterfaceAttribute", 
              "ec2:UnassignPrivateIpAddresses"
      ],            
      Effect = "Allow", 
      Resource = "*"
    },
    {   
      "Effect": "Allow", 
      "Action": [ 
        "ec2:CreateTags" 
      ],
      "Resource": [
          "arn:aws:ec2:*:*: network-interface/*"
      ]
    }
  ]    
})
}

resource "aws_iam_role_policy_attachment" "cni_role_attachment" {
  policy_arn = aws_iam_policy.cni_policy.arn
  role       = aws_iam_role.cni_role.name
  
}