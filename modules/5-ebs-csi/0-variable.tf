variable "eks-cluster" {}

variable "ebs-csi-sa" {
  default = "ebs-csi-sa"
  type = string 
}