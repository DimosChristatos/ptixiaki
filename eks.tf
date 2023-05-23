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
    role_arn = aws_iam_role.eks_cluster_role.arn
    
    vpc_config { 
        endpoint_private_access = false
        endpoint_public_access = true

        subnet_ids = [
            aws_subnet.my_public_subnet_1.id,
            aws_subnet.my_public_subnet_2.id,
            aws_subnet.my_private_subnet_1.id,
            aws_subnet.my_private_subnet_2.id
        ]
    }

    depends_on = [
        aws_iam_role_policy_attachment.eks_cluster_policy_attachment
    ]
}