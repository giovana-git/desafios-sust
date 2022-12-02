resource "aws_cloudfront_distribution" "s3-dist" {

  depends_on = [
    aws_acm_certificate.acm-terraform
  ]

  origin {
    domain_name = aws_s3_bucket.terraform-bucket.bucket_regional_domain_name
    origin_id   = local.s3_origin_id
  }

  default_root_object = "index.html"
  enabled             = true

  aliases = ["s3.giovanaalmeida.ga"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }


  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {

    acm_certificate_arn = aws_acm_certificate.acm-terraform.arn
    ssl_support_method  = "sni-only"
  }
}