output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc_with_subnets.vpc_id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc_with_subnets.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc_with_subnets.public_subnets
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = module.eks_with_node_group.cluster_certificate_authority_data
}

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = module.eks_with_node_group.cluster_endpoint
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster for the OpenID Connect identity provider"
  value       = module.eks_with_node_group.cluster_oidc_issuer_url
}