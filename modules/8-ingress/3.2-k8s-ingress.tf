# #Kubernetes Service Manifest (Type: Load Balancer)
# resource "kubernetes_ingress_v1" "ingress-svc-ssl" {
#   metadata {
#     name = "${var.ingress_svc_name}"
#     namespace = "${var.ingress_svc_namespace}"
#     annotations = {
#       # Load Balancer Name
#       "alb.ingress.kubernetes.io/load-balancer-name" = "${var.ingress_svc_name}-lb"
#       # Ingress Core Settings
#       "alb.ingress.kubernetes.io/scheme" = "internet-facing"
#       # Health Check Settings
#       "alb.ingress.kubernetes.io/healthcheck-protocol" =  "HTTP"
#       "alb.ingress.kubernetes.io/healthcheck-port" = "traffic-port"
#       #Important Note:  Need to add health check path annotations in service level if we are planning to use multiple targets in a load balancer    
#       "alb.ingress.kubernetes.io/healthcheck-interval-seconds" = 15
#       "alb.ingress.kubernetes.io/healthcheck-timeout-seconds" = 5
#       "alb.ingress.kubernetes.io/success-codes" = 200
#     #   "alb.ingress.kubernetes.io/healthy-threshold-count" = 2
#     #   "alb.ingress.kubernetes.io/unhealthy-threshold-count" = 2
#       ## SSL Settings
#       "alb.ingress.kubernetes.io/listen-ports" = jsonencode([{"HTTPS" = 443}, {"HTTP" = 80}])
#       # Prevent user from accessing from port 80
#       #"alb.ingress.kubernetes.io/listen-ports" = jsonencode([{"HTTPS" = 443}])
#       "alb.ingress.kubernetes.io/certificate-arn" =  "${aws_acm_certificate.acm_cert.arn}"
#       # SSL Redirect Setting
#       "alb.ingress.kubernetes.io/ssl-redirect" = 443
#     }    
#   }
#   spec {
#     ingress_class_name = "${kubernetes_ingress_class_v1.ingress_class.metadata.0.name}" # Ingress Class            
    
#     rule {
#       host = "app.langocanh.net"
#       http {
#         path {
#           path = "/api"
#           path_type = "Prefix"
#           backend {
#             service {
#               # backend deployment name
#               name = "api"
#               port {
#                 number = 8080
#               }
#             }
#           }
#         }
#         ####
#         path {
#           path = "/"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = "frontend"
#               port {
#                 number = 3000
#               }
#             }
#           }
#         }
#         ####
#       }
#     }
#   }

# }
