# Install Cluster Autoscaler using HELM

# Resource: Helm Release 
resource "helm_release" "cluster_autoscaler_release" {
  depends_on = [aws_iam_role.irsa-role]            
  name       = "cluster-autoscaler-ca"

  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"

  namespace = "kube-system"   

  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = data.terraform_remote_state.eks.outputs.eks-cluster.cluster_id
  }

  set {
    name  = "awsRegion"
    value = "us-east-1"
  }

  set {
    name  = "rbac.serviceAccount.create"
    value = "false"
  }

  set {
    name  = "rbac.serviceAccount.name"
    value = "${var.service-account-name}"
  }

  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "${aws_iam_role.irsa-role.arn}"
  }   
   
}