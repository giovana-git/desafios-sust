resource "aws_route53_record" "record-acm" {

  allow_overwrite = true
  name            = tolist(aws_acm_certificate.acm-terraform.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.acm-terraform.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.acm-terraform.domain_validation_options)[0].resource_record_type
  zone_id         = "Z08455282BL7EOZCP7XP1"
  ttl             = 60
}

resource "aws_route53_record" "record-cloudfront" {
  zone_id = "Z08455282BL7EOZCP7XP1"
  name    = "s3.giovanaalmeida.ga"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3-dist.domain_name
    zone_id                = aws_cloudfront_distribution.s3-dist.hosted_zone_id
    evaluate_target_health = false
  }
}