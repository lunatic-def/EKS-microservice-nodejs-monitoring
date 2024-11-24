variable "eks-cluster" {}

variable "service-account-name" {
  default = "efs-csi-controller-sa"
  type = string
}
variable "service-account-namespace"{
  default = "kube-system"
  type = string
}

