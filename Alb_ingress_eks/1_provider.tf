provider "kubectl" {
  # host = data.aws_eks_cluster_enpoint.cluster
  host = module.aws_eks_cluster.my_cluster.eks_cluster_endpoint
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    # args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.my_cluster]
    args        = ["eks", "get-token", "--cluster-name", module.aws_eks_cluster.my_cluster.eks_cluster_id]
    command     = "aws"
  }
  cluster_ca_certificate = base64decode(module.aws_eks_cluster.my_cluster.eks_cluster_id)
  load_config_file       = false
}