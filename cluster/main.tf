# invoking vpc and subnets modules
module "vpc_with_subnets" {
  # invoke vpc_and_subnets module under modules directory
  source = "../modules/vpc_and_subnets"

  # passing the required parameters
  name     = var.vpc_name
  vpc_cidr = var.vpc_cidr
}

# invoking eks module to eks cluster and node group
module "eks_with_node_group" {
  # invoke eks module under modules directory
  source = "../modules/eks"

  # passing the required parameters
  eks_cluster_name = var.eks_cluster_name
  k8s_version      = var.k8s_version

  # pass vpc and subnet details from vpc_with_subnets module
  vpc_id                     = module.vpc_with_subnets.vpc_id
  eks_node_groups_subnet_ids = module.vpc_with_subnets.private_subnets
  control_plane_subnet_ids   = module.vpc_with_subnets.private_subnets
}