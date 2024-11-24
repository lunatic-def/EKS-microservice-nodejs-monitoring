# # Step 2
# # 1) Create IAM role with OpenID provider extracted identity to provide Temporary role credential for Kubernetes Service Account !!
# resource "aws_iam_role" "irsa-role" {
#     name = "irsa-role"
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
#               Federated = "${data.terraform_remote_state.eks.outputs.eks-irsa.aws_iam_openid_connect_provider_arn}"
#               #Federated = "${resource.aws_iam_openid_connect_provider.oidc_provider.arn}"
#             }
#             # Only allow specific service account "irsa-service-account" to assume role !!
#             Condition = {
#               StringEquals = {            
#                 "${data.terraform_remote_state.eks.outputs.eks-irsa.aws_iam_openid_connect_provider_extract_from_arn}:sub": "system:serviceaccount:default:irsa-service-account"
#                 #"${local.aws_iam_oidc_connect_provider_extract_from_arn}:sub": "system:serviceaccount:default:irsa-service-account"
#               }
#             }        
#           },
#         ]
#   })
#   tags = {
#     tag-key = "irsa-role"
#   }
# }

# # 2) Associate IAM policy for role
# resource "aws_iam_role_policy_attachment" "irsa_iam_role_policy_attach" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
#   role       = aws_iam_role.irsa-role.name
# }

