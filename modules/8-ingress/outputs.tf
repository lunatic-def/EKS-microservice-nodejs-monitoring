# # Output ACM Certificate ARN
# output "acm_certificate_arn" {
#   description = "The ARN of the certificate"
#   value       = aws_acm_certificate.acm_cert.arn
# }

# output "acm_certificate_id" {
#   value = aws_acm_certificate.acm_cert.id 
# }

# output "acm_certificate_status" {
#   value = aws_acm_certificate.acm_cert.status
# }

# # Output MyDomain Zone ID
# output "mydomain_zoneid" {
#   description = "The Hosted Zone id of the desired Hosted Zone"
#   value = data.aws_route53_zone.mydomain.zone_id 
# }

# # Output MyDomain name
# output "mydomain_name" {
#   description = " The Hosted Zone name of the desired Hosted Zone."
#   value = data.aws_route53_zone.mydomain.name
# }

# # output "data-kube"{
# #     description = "Ingress hostname"
# #     value = data.kubernetes_ingress_v1.ingress-ssl
# # }

# output "aws_lb" {
#     value =  data.aws_lb.ingress-lb.zone_id
# }

# output "aws_lb_dns" {
#     value =  data.aws_lb.ingress-lb.dns_name
# }