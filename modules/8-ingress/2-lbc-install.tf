# # helms provider resource https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html
# resource "helm_release" "loadbalancer_controller"{
#     name = "aws-lbc-driver"
#     repository = "https://aws.github.io/eks-charts"
#     namespace = "kube-system"
#     chart = "aws-load-balancer-controller" 

#   set {
#      name  = "image.repository"
#      value = "602401143452.dkr.ecr.us-east-1.amazonaws.com/amazon/aws-load-balancer-controller"
#   } 

#    set {
#     name  = "serviceAccount.create"
#     value = "false"
#   }

#   set {
#     name  = "serviceAccount.name"
#     value = "${var.service-account-name}"
#   }

#   set {
#     name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
#     value = module.aws_load_balancer_controller_irsa_role.iam_role_arn
#   }

#   set {
#     name  = "clusterName"
#     value = "${data.terraform_remote_state.eks.outputs.eks-cluster.cluster_id}"
#   }

#   set {
#     name  = "region"
#     value = "${data.terraform_remote_state.eks.outputs.vpc.region}"
#   }

#   set {
#     name  = "vpcId"
#     value = "${data.terraform_remote_state.eks.outputs.vpc.vpc_id}"
#   }

#   depends_on = [ module.aws_load_balancer_controller_irsa_role ]
# }


resource "helm_release" "aws_load_balancer_controller" {
  name = "aws-load-balancer-controller"

  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  version    = "1.4.4"

  set {
    name  = "replicaCount"
    value = 1
  }

  set {
    name  = "clusterName"
    value = "${data.terraform_remote_state.eks.outputs.eks-cluster.cluster_id}"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.aws_load_balancer_controller_irsa_role.iam_role_arn
  }
}