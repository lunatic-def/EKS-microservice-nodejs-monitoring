# Step 2
# 1) Create IAM role with OpenID provider extracted identity to provide Temporary role credential for Kubernetes Service Account !!
resource "aws_iam_role" "irsa-role" {
    name = "ebs-csi-controller-sa"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            # sts JWT
            Action = "sts:AssumeRoleWithWebIdentity"
            Effect = "Allow"
            Sid    = ""
            # Provider indentity
            Principal = {
              Federated = "${data.terraform_remote_state.eks.outputs.eks-oidc.aws_iam_openid_connect_provider_arn}"
            }
            # Only allow specific service account "ebs-csi-controller-sa" to assume role !! for AWS EKS Add-on SA
            Condition = {
              StringEquals = {            
                "${data.terraform_remote_state.eks.outputs.eks-oidc.aws_iam_openid_connect_provider_extract_from_arn}:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa"
              }
            }        
          },
        ]
  })
  tags = {
    tag-key = "ebs-csi-controller-sa"
  }
}

# 2) Associate IAM policy for role
resource "aws_iam_role_policy_attachment" "irsa_iam_role_policy_attach" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.irsa-role.name
}

