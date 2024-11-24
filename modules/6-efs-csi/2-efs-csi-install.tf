# helms provider resource https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html
resource "helm_release" "loadbalancer_controller"{
    name = "aws-efs-csi-driver"
    namespace = "${var.service-account-namespace}"

    repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver"
    chart      = "aws-efs-csi-driver"

  set {
     name  = "image.repository"
     value = "602401143452.dkr.ecr.us-east-1.amazonaws.com/eks/aws-efs-csi-driver"
  } 

   set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = "${var.service-account-name}"
  }

  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "${aws_iam_role.irsa-role.arn}"
  }

  set {
    name  = "clusterName"
    value = "${data.terraform_remote_state.eks.outputs.eks-cluster.cluster_id}"
  }

  set {
    name  = "region"
    value = "${data.terraform_remote_state.eks.outputs.vpc.region}"
  }

  set {
    name  = "vpcId"
    value = "${data.terraform_remote_state.eks.outputs.vpc.vpc_id}"
  }

  depends_on = [ aws_iam_role.irsa-role, kubernetes_service_account_v1.irsa_demo_sa ]
}