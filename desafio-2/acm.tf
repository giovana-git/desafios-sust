resource "aws_acm_certificate" "acm-terraform" {
  domain_name       = "*.giovanaalmeida.ga"
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "acm-validation" {

  certificate_arn         = aws_acm_certificate.acm-terraform.arn
  validation_record_fqdns = [aws_route53_record.record-acm.fqdn]
}