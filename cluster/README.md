# cluster

This is top level module creates vpc, subnets and eks cluster by calling [vpc_and_subnets](../modules/vpc_and_subnets/README.md) and [eks](../modules/eks/README.md) modules.

## Summary

This module creates following resources -
- VPC
- Subnets (3 public and 3 private)
- 1 NAT Gateway per AZ with corresponding Elasic IPs
- Internet Gateway
- Public and Private Route tables
- EKS Cluster with OIDC Provider
- [EKS Managed AddOns](https://docs.aws.amazon.com/eks/latest/userguide/eks-add-ons.html)
  - coredns
  - vpc-cni
  - kube-proxy
- EKS Managed node group


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.6.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.6.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks_with_node_group"></a> [eks\_with\_node\_group](#module\_eks\_with\_node\_group) | [eks](../modules/eks) | n/a |
| <a name="module_vpc_with_subnets"></a> [vpc\_with\_subnets](#module\_vpc\_with\_subnets) | [vpc_and_subnets](../modules/vpc_and_subnets) | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | eks cluster name | `string` | n/a | yes |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | kubernetes version | `string` | `"1.27"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | vpc cidr block to be used | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | name of the vpc to be created | `string` | `"platformwale"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | Base64 encoded certificate data required to communicate with the cluster |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for your Kubernetes API server |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | The URL on the EKS cluster for the OpenID Connect identity provider |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | List of IDs of private subnets |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | List of IDs of public subnets |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
