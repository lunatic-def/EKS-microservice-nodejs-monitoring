# Resource: EBS CSI Driver AddOn
# Install EBS CSI Driver using EKS Add-Ons
resource "aws_eks_addon" "ebs_eks_addon" {
  depends_on = [ aws_iam_role_policy_attachment.irsa_iam_role_policy_attach]
  cluster_name = data.terraform_remote_state.eks.outputs.eks-cluster.cluster_id
  addon_name   = "aws-ebs-csi-driver"
  addon_version     = "v1.35.0-eksbuild.1"
  service_account_role_arn = aws_iam_role.irsa-role.arn
}

