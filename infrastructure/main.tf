module "vpc" {
  source = "../modules/1-vpc"
}

output "vpc" {
  value = module.vpc
}

# module "bastion-instance" {
#   source = "../modules/2-ec2"
#   vpc = module.vpc
# }

# output "bastion-instance" {
#   value = module.bastion-instance
# }

# module "rds"{
#   source = "../modules/3-rds"
#   depends_on = [ module.vpc ]
#   vpc = module.vpc
#   db_instance_identifier = var.db_instance_identifier
#   db_name                = var.db_name
#   db_username            = var.db_username
#   db_password            = var.db_password
  
# }

# output "rds"{
#   value = module.rds
# }

module "eks-cluster" {
  source = "../modules/4-eks"
  vpc = module.vpc
}

output "eks-cluster" {
  value = module.eks-cluster
}

#Kubernetes job testing modules
module "eks-oidc" {
  source = "../modules/4-eks-oidc"
  eks-cluster = module.eks-cluster
}

output "eks-oidc" {
  value = module.eks-oidc
}

# module "ebs-csi" {
#   source = "../modules/5-ebs-csi"
#   eks-cluster = module.eks-cluster
# }

# output "ebs-csi" {
#   value = module.ebs-csi
# }

# module "istio-backend"{
#   source = "../modules/7-istio-backend"
#   eks-cluster = module.eks-cluster
# }

#NEED To configure K8s && helm provider for this module to work !!
module "eks-ingress" {
  source = "../modules/8-ingress"
  eks-cluster = module.eks-cluster
}

# output "eks-ingress" {
#   value = module.eks-ingress
# }

module "eks-autoscaler" {
  source = "../modules/9-autoscaler"
  eks-cluster = module.eks-cluster
}

module "eks-monitoring" {
  source = "../modules/10-monitoring"
}