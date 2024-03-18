locals {
  vpc_cidr = "10.0.0.0/16"
  azs = ["sa-east-1a", "sa-east-1b", "sa-east-1c"]
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "qa"
  cidr = local.vpc_cidr

  enable_vpn_gateway = true
  enable_dns_hostnames = true
  map_public_ip_on_launch = true

  azs = local.azs

  private_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  public_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]
  database_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 8)]

  enable_ipv6 = true
  public_subnet_assign_ipv6_address_on_creation = true

  public_subnet_ipv6_prefixes = [0, 1, 2]
  private_subnet_ipv6_prefixes = [3, 4, 5]
  database_subnet_ipv6_prefixes = [6, 7, 8]

  // Nat Gateway
  enable_nat_gateway = false
  single_nat_gateway = true
  one_nat_gateway_per_az = false
}
