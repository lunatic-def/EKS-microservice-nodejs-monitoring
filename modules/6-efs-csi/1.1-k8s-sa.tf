# Kubernete provider resource
resource "kubernetes_service_account_v1" "irsa_demo_sa" {
  depends_on = [ aws_iam_role_policy_attachment.irsa_iam_role_policy_attach ]
  metadata {
    name = "${var.service-account-name}"
    namespace = "${var.service-account-namespace}"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.irsa-role.arn
      }
  }
}