# setup aws terraform provider version to be used
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.6.2"
    }
  }
}

module "eks" {
  # invoke public eks module
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  # eks cluster name and version
  cluster_name    = var.eks_cluster_name
  cluster_version = var.k8s_version

  # vpc id where the eks cluster security group needs to be created
  vpc_id = var.vpc_id

  # subnets where the eks cluster needs to be created
  control_plane_subnet_ids = var.control_plane_subnet_ids

  # to enable public and private access for eks cluster endpoint
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  # create an OpenID Connect Provider for EKS to enable IRSA
  enable_irsa = true

  # install eks managed addons
  # more details are here - https://docs.aws.amazon.com/eks/latest/userguide/eks-add-ons.html
  cluster_addons = {
    # extensible DNS server that can serve as the Kubernetes cluster DNS
    coredns = {
      preserve    = true
      most_recent = true
    }

    # maintains network rules on each Amazon EC2 node. It enables network communication to your Pods
    kube-proxy = {
      most_recent = true
    }

    # a Kubernetes container network interface (CNI) plugin that provides native VPC networking for your cluster
    vpc-cni = {
      most_recent = true
    }
  }

  # subnets where the eks node groups needs to be created
  subnet_ids = var.eks_node_groups_subnet_ids

  # eks managed node group named worker
  eks_managed_node_groups = var.workers_config

}