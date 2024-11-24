
# Step 1 
data "aws_partition" "current" {}

# AWS IAM Open ID Connect Provider
resource "aws_iam_openid_connect_provider" "oidc_provider" {
  client_id_list  = ["sts.${data.aws_partition.current.dns_suffix}"]
  thumbprint_list = [local.eks-oidc-thumbprint]
  url             = var.eks-cluster.identity[0].oidc[0].issuer
}

