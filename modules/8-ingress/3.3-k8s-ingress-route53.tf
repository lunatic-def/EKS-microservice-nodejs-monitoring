# # data "aws_lb" "ingress-lb"{
# #     name = "${var.ingress_svc_name}-lb"
# #     depends_on = [kubernetes_ingress_v1.ingress-svc-ssl] 
# # }

# data "aws_lb" "ingress-lb"{
#     tags = {
#         "elbv2.k8s.aws/cluster" = "${var.eks-cluster}"
#         "ingress.k8s.aws/resource" = "LoadBalancer"
#         "ingress.k8s.aws/stack" = "${var.ingress_svc_namespace}/${var.ingress_svc_name}"
#     }
#     depends_on = [kubernetes_ingress_v1.ingress-svc-ssl] 
# }
# resource "aws_route53_record" "ingress-record" {
#   zone_id = data.aws_route53_zone.mydomain.zone_id 
#   name    = "apps.langocanh.net"
#   type    = "A"
#   alias {
#     name = data.aws_lb.ingress-lb.dns_name
#     zone_id = data.aws_lb.ingress-lb.zone_id
#     evaluate_target_health = true
#   }
#   depends_on = [kubernetes_ingress_v1.ingress-svc-ssl]
# }





