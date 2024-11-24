# # 1) Create IAM role with OpenID provider extracted identity to provide Temporary role credential for Kubernetes Service Account !!
# resource "aws_iam_role" "irsa-role" {
#     name = "${var.service-account-name}-role"
#     assume_role_policy = jsonencode({
#         Version = "2012-10-17"
#         Statement = [
#           {
#             # sts JWT
#             Action = "sts:AssumeRoleWithWebIdentity"
#             Effect = "Allow"
#             Sid    = ""
#             # Provider indentity
#             Principal = {
#               Federated = "${data.terraform_remote_state.eks.outputs.eks-oidc.aws_iam_openid_connect_provider_arn}"
#             }
#             Condition = {
#               StringEquals = {            
#                 "${data.terraform_remote_state.eks.outputs.eks-oidc.aws_iam_openid_connect_provider_extract_from_arn}:sub": "system:serviceaccount:${var.service-account-namespace}:${var.service-account-name}"
#               }
#             }        
#           },
#         ]
#   })
#   tags = {
#     tag-key = "${var.service-account-name}-role"
#   }
# }

# # 2) Associate IAM policy for role
# data "http" "lb-controller-policy" {
#   url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.7.2/docs/install/iam_policy.json"

#   # Optional request headers
#   request_headers = {
#     Accept = "application/json"
#   }
# }

# resource "aws_iam_policy" "lbc_iam_policy" {
#   name        = "AWSLoadBalancerControllerIAMPolicy"
#   path        = "/"
#   description = "AWS Load Balancer Controller IAM Policy"
#   policy = data.http.lb-controller-policy.response_body
# }

# resource "aws_iam_role_policy_attachment" "irsa_iam_role_policy_attach" {
#   policy_arn = aws_iam_policy.lbc_iam_policy.arn
#   role       = aws_iam_role.irsa-role.name
# }
