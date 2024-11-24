variable "eks-cluster" {}

locals {
  eks-oidc-thumbprint = "9451ad2b53c7f41fab22886cc07d482085336561"
}

variable "service-account-name" {
  default = "aws-load-balancer-controller"
  type = string
}
variable "service-account-namespace"{
  default = "kube-system"
  type = string
}

# Ingress
variable "ingress_svc_name"{
  default = "ingress-svc-ssl"
  type = string
}

variable "ingress_svc_namespace"{
  default = "workshop"
  type = string
}


# Get DNS information from AWS Route53
data "aws_route53_zone" "mydomain" {
  name         = "langocanh.net"
}

