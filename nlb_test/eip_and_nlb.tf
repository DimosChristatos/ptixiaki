provider "aws" {
  region = "us-east-1" 
}

resource "aws_lb" "public_nlb" {
  name               = "my-public-nlb"
  load_balancer_type = "network"
  enable_deletion_protection = false

  subnet_mapping {
    subnet_id = aws_subnet.public_subnet1.id  # Replace with your public subnet ID
    allocation_id = aws_eip.public_eip.id
  }
}

resource "aws_lb_target_group" "public_nlb_target_group" {
  name     = "my-public-nlb-target-group"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.vpc.id
}

resource "aws_lb_listener" "public_nlb_listener" {
  load_balancer_arn = aws_lb.public_nlb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_nlb_target_group.arn
    
  }
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet1" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.vpc.id
  availability_zone = "us-east-1a"
}
resource "aws_subnet" "public_subnet2" {
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.vpc.id
  availability_zone = "us-east-1b"
}

resource "aws_eip" "public_eip" {
  vpc = true
}

resource "aws_internet_gateway" "gateway"{
  vpc_id = aws_vpc.vpc.id
}



# CLUSTER
resource "aws_iam_role" "eks_cluster_role" {
    name = "eks-cluster-role"
    assume_role_policy = <<EOF
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
EOF
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_eks_cluster" "cluster" {
    name = "eks"
    version  = "1.22"
    role_arn = aws_iam_role.eks_cluster_role.arn
    
    vpc_config { 
        endpoint_private_access = false
        endpoint_public_access = true

        subnet_ids = [
            aws_subnet.public_subnet1.id,
            aws_subnet.public_subnet2.id
        ]
    }

    depends_on = [
        aws_iam_role_policy_attachment.eks_cluster_policy_attachment
    ]
}