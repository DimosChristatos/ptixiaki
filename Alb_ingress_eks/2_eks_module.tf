module "eks_cluster" {
  source = "./eks_module"
  cluster_name = "knot_cluster"
}