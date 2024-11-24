module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.1"

  #Asset VPC Details

  name = var.name
  cidr = var.cidr

  azs = var.azs
  private_subnets = var.vpc_private_subnets
  public_subnets = var.vpc_public_subnets


  database_subnets = var.vpc_database_subnets

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true
  # NAT gateway
  enable_nat_gateway = false
  single_nat_gateway = false

  # Additional Tags to Subnets
  public_subnet_tags = {
    Type = "Public Subnets"
    "kubernetes.io/role/elb" = 1    
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"        
  }
  private_subnet_tags = {
    Type = "private-subnets"
    "kubernetes.io/role/internal-elb" = 1    
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"    
  }

  database_subnet_tags = {
    Type = "Private Database Subnets"
  }

  # Instances launched into the Public subnet should be assigned a public IP address.
  map_public_ip_on_launch = true
}


