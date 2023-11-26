resource "aws_iam_role" "my_eks_node_role" {
  name = "my-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_eks_node_group" "my_nodes" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "knot-nodes"
  node_role_arn   = aws_iam_role.my_eks_node_role.arn
  subnet_ids      = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_1.id
  ]
  capacity_type = "SPOT"
  instance_types = ["t3a.small"]

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 1
  }
}