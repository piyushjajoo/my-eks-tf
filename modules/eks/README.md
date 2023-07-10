# eks module

This is the documentation for eks module.

## Summary

This module creates following resources -
- eks cluster in provided subnets with public and private access endpoints
- oidc provider for IRSA
- [EKS Managed AddOns](https://docs.aws.amazon.com/eks/latest/userguide/eks-add-ons.html)
  - vpc-cni
  - coredns
  - kube-proxy
- eks managed node group named `worker` in the provided subnets, creates SPOT instances of type `t3.large`

This module only requires you to specify eks cluster name, k8s version, vpc id, eks cluster subnet ids and eks managed node groups subnet ids. All the other variables have default values. If the default values are used, this module creates all the resources mentioned above. Please read the documentation below to know details about the variables accepted by this module.

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
| <a name="module_eks"></a> [eks](#module\_eks) | [terraform-aws-modules/eks/aws](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/19.15.3) | 19.15.3 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_control_plane_subnet_ids"></a> [control\_plane\_subnet\_ids](#input\_control\_plane\_subnet\_ids) | subnet ids where the eks cluster should be created | `list(string)` | n/a | yes |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | eks cluster name | `string` | n/a | yes |
| <a name="input_eks_node_groups_subnet_ids"></a> [eks\_node\_groups\_subnet\_ids](#input\_eks\_node\_groups\_subnet\_ids) | subnet ids where the eks node groups needs to be created | `list(string)` | n/a | yes |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | kubernetes version | `string` | `"1.27"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | vpc id where the cluster security group needs to be created | `string` | n/a | yes |
| <a name="input_workers_config"></a> [workers\_config](#input\_workers\_config) | workers config | `map(any)` | <pre>{<br>  "worker": {<br>    "capacity_type": "SPOT",<br>    "desired_size": 1,<br>    "instance_types": [<br>      "t3.large"<br>    ],<br>    "max_size": 2,<br>    "min_size": 1<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | The Amazon Resource Name (ARN) of the cluster |
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | Base64 encoded certificate data required to communicate with the cluster |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for your Kubernetes API server |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | The URL on the EKS cluster for the OpenID Connect identity provider |
| <a name="output_oidc_provider"></a> [oidc\_provider](#output\_oidc\_provider) | The OpenID Connect identity provider (issuer URL without leading `https://`) |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | The ARN of the OIDC Provider |