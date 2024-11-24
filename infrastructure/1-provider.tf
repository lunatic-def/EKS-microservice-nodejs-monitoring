terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.33.0"
    }        
  }
  # Adding Backend as S3 for Remote State Storage
  # backend "s3" {
  #   bucket = "eks-state-datasource-bucket"
  #   key    = "dev/app1k8s/terraform.tfstate"
  #   region = "us-east-1" 

  #   # For State Locking
  #   #dynamodb_table = "dev-app1k8s"    
  # }     
}

# Provider AWS
provider "aws" {
  region  = var.aws_region
  profile = "default"
  access_key = var.access_key
  secret_key = var.secret_key
}

provider "kubernetes" {
  host                   = data.terraform_remote_state.eks.outputs.eks-cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

#HELM Provider
provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.eks.outputs.eks-cluster.cluster_endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}