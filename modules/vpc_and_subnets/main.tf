# setup aws terraform provider version to be used
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.6.2"
    }
  }
}

# to retrieve the availability zones
data "aws_availability_zones" "available" {}


locals {
  # newbits is the new mask for the subnet, which means it will divide the VPC into 256 (2^(32-24)) subnets.
  newbits = 8

  # netcount is the number of subnets that we need, which is 6 in this case
  netcount = 6

  # cidrsubnet function is used to divide the VPC CIDR block into multiple subnets
  all_subnets = [for i in range(local.netcount) : cidrsubnet(var.vpc_cidr, local.newbits, i)]

  # we create 3 public subnets and 3 private subnets using these subnet CIDRs
  public_subnets  = slice(local.all_subnets, 0, 3)
  private_subnets = slice(local.all_subnets, 3, 6)
}

# vpc module to create vpc, subnets, NATs, IGW etc..
module "vpc_and_subnets" {
  # invoke public vpc module
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  # vpc name
  name = var.name

  # availability zones
  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  # vpc cidr
  cidr = var.vpc_cidr

  # public and private subnets
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  # create nat gateways
  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = var.single_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az

  # enable dns hostnames and support
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  # tags for public, private subnets and vpc
  tags                = var.tags
  public_subnet_tags  = var.additional_public_subnet_tags
  private_subnet_tags = var.additional_private_subnet_tags

  # create internet gateway
  create_igw       = var.create_igw
  instance_tenancy = var.instance_tenancy

}