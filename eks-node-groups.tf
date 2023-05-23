resource "aws_iam_role" "node_role" {
    name = "eks_nodes"

    assume_role_policy = <<EOF
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
EOF
}

resource "aws_iam_role_policy_attachment" "nodes_amazon_eks_worker_node_policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role       = aws_iam_role.node_role.name
}

resource "aws_iam_role_policy_attachment" "nodes_amazon_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_role.name
}

resource "aws_iam_role_policy_attachment" "nodes_amazon_ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_role.name
}

resource "aws_eks_node_group" "node_group"{
    cluster_name = aws_eks_cluster.cluster.name
    node_group_name = "node_group"
    node_role_arn = aws_iam_role.node_role.arn

    subnet_ids = [
        aws_subnet.my_private_subnet_1.id
    ]

    scaling_config {
        desired_size = 1
        max_size = 1
        min_size = 0
    }

    capacity_type = "ON_DEMAND"
    instance_types = ["t3.small"]

    depends_on = [
        aws_iam_role_policy_attachment.nodes_amazon_eks_worker_node_policy,
        aws_iam_role_policy_attachment.nodes_amazon_eks_cni_policy,
        aws_iam_role_policy_attachment.nodes_amazon_ec2_container_registry_read_only
    ]
}