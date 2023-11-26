# data "terraform_remote_state" "eks" {
#     backend = "local" 
#     config = {
#       path = "/terraform.tfstate"
#     }
# }

# data "aws_eks_cluster_endpoint" "cluster"{
#     name = data.terraform_remote_state.eks.outputs.eks_cluster_endpoint
# }

# data "aws_eks_cluster" "cluster"{
#     name = data.terraform_remote_state.eks.outputs.eks_cluster_id
# }

# data "aws_eks_cluster_auth" "cluster"{
#     name = data.terraform_remote_state.eks.outputs.eks_cluster_id
# }
