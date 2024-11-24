# 1) Create IAM role with OpenID provider extracted identity to provide Temporary role credential for Kubernetes Service Account !!
resource "aws_iam_role" "irsa-role" {
    name = "${var.service-account-name}-role"
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
            Condition = {
              StringEquals = {            
                "${data.terraform_remote_state.eks.outputs.eks-oidc.aws_iam_openid_connect_provider_extract_from_arn}:sub": "system:serviceaccount:${var.service-account-namespace}:${var.service-account-name}"
              }
            }        
          },
        ]
  })
  tags = {
    tag-key = "${var.service-account-name}-role"
  }
}
# Resource: IAM Policy for Cluster Autoscaler
resource "aws_iam_policy" "cluster_autoscaler_iam_policy" {
  name        = "AmazonEKSClusterAutoscalerPolicy"
  path        = "/"
  description = "EKS Cluster Autoscaler Policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeTags",
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup",
                "ec2:DescribeLaunchTemplateVersions",
                "ec2:DescribeInstanceTypes"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
})
}


resource "aws_iam_role_policy_attachment" "irsa_iam_role_policy_attach" {
  policy_arn = aws_iam_policy.cluster_autoscaler_iam_policy.arn
  role       = aws_iam_role.irsa-role.name
}
