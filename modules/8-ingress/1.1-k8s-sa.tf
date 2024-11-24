# # Kubernete provider resource
# resource "kubernetes_service_account_v1" "irsa_demo_sa" {
#   depends_on = [ aws_iam_role_policy_attachment.irsa_iam_role_policy_attach ]
#   metadata {
#     name = "${var.service-account-name}"
#     namespace = "kube-system"
#     annotations = {
#       "eks.amazonaws.com/role-arn" = aws_iam_role.irsa-role.arn
#       }
#   }
# }

module "aws_load_balancer_controller_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.30.0"

  role_name = "${var.service-account-name}"

  attach_load_balancer_controller_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = data.terraform_remote_state.eks.outputs.eks-oidc.aws_iam_openid_connect_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }
}
