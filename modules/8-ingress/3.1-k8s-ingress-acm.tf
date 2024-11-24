resource "aws_acm_certificate" "acm_cert" {
  domain_name       = "*.langocanh.net"
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# !! Need to approve record on acm first 