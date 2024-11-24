variable "eks-cluster" {}

locals {
  eks-oidc-thumbprint = "9451ad2b53c7f41fab22886cc07d482085336561"
}

variable "service-account-name" {
  default = "cluster-autoscaler"
  type = string
}
variable "service-account-namespace"{
  default = "kube-system"
  type = string
}



