# # S3 creation
# module "s3-backend" {
#   source  = "terraform-aws-modules/s3-bucket/aws"
#   version = "4.2.1"
#   bucket = "eks-state-datasource-bucket"
#   force_destroy = true

#   # S3 bucket-level Public Access Block configuration (by default now AWS has made this default as true for S3 bucket-level block public access)
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true

#   versioning = {
#     status     = true
#     mfa_delete = false
#   }
#   acl    = "private"
# }

# # Create folders in the S3 bucket
# resource "aws_s3_bucket_object" "dev_folder" {
#   bucket = module.s3-backend.bucket
#   key    = "dev/"
# }

# resource "aws_s3_bucket_object" "eks_cluster_folder" {
#   bucket = module.s3-backend.bucket
#   key    = "dev/eks-cluster/"
# }

# resource "aws_s3_bucket_object" "app1k8s_folder" {
#   bucket = module.s3-backend.bucket
#   key    = "dev/app1k8s/"
# }

#remote state-datasource
# data "terraform_remote_state" "eks" {
#   backend = "s3"
#   config = {
#     bucket = "eks-state-datasource-bucket"
#     key    = "dev/eks-cluster/terraform.tfstate"
#     region = "us-east-1" 
#   }
# }

#Local tfstate
data "terraform_remote_state" "eks"{
  backend = "local"
  config = {
    path = "./terraform.tfstate"
  }
}
# Provider Kubernets
data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.eks-cluster.cluster_id
}
# Authentication token to communicate with cluster
data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.eks-cluster.cluster_id
}