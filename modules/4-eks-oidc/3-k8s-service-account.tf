# NEED KUBERNETES PROVIDERS !!!!! 
# resource "kubernetes_service_account_v1" "irsa_demo_sa" {
#   depends_on = [ aws_iam_role_policy_attachment.irsa_iam_role_policy_attach ]
#   metadata {
#     name = "irsa-service-account"
#     annotations = {
#       "eks.amazonaws.com/role-arn" = aws_iam_role.irsa-role.arn
#       }
#   }
# }