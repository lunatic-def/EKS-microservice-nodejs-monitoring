# # Kubernetes provider resource
# #https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.2/guide/ingress/ingress_class/
# resource "kubernetes_ingress_class_v1" "ingress_class" {
#   depends_on = [helm_release.loadbalancer_controller]
#   metadata {
#     name = "ingressclass-alb"
#     annotations = {
#       "ingressclass.kubernetes.io/is-default-class" = "true"
#     }
#   }  
#   spec {
#     controller = "ingress.k8s.aws/alb"
#   }
# }

