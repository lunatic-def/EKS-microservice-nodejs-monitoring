
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}
# VPC Private Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

# VPC Public Subnets
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

# VPC Database subnets
output "database_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.database_subnets
}

# VPC AZs
output "azs" {
  description = "A list of availability zones spefified as argument to this module"
  value       = module.vpc.azs
}

output "cidr_blocks" {
  value = var.cidr
}

output "region" {
  value = var.region
}