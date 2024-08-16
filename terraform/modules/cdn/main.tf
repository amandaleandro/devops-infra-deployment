resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = "example.com"
    origin_id   = "mys3origin"
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["us"]
    }
  }

  default_cache_behavior {
    allowed_methods  = ["get", "head", "options"]
    cached_methods   = ["get", "head"]
    target_origin_id = "mys3origin"
    viewer_protocol_policy = "redirect-to-https"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  enabled = true
}
