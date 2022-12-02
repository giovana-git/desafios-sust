resource "aws_s3_bucket" "terraform-bucket" {

  bucket = var.bucket_name
  acl    = var.acl
}

resource "aws_s3_bucket_policy" "s3-policy" {

  bucket = aws_s3_bucket.terraform-bucket.id
  policy = <<POLICY
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "PublicReadGetObject",
			"Effect": "Allow",
			"Principal": "*",
			"Action": "s3:GetObject",
			"Resource": "arn:aws:s3:::bucket-website-cloudfront/*"
		}
	]
}
POLICY
}


resource "aws_s3_bucket_website_configuration" "s3-website" {

  bucket = aws_s3_bucket.terraform-bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "index" {

  bucket       = aws_s3_bucket.terraform-bucket.id
  key          = "index.html"
  source       = "./documents/index.html"
  content_type = "text/html"
  acl          = "public-read"
}

locals {
  s3_origin_id = "myS3Origin"
}