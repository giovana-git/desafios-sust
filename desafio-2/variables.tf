variable "region" {
  type    = string
  default = "us-east-1"
}

variable "bucket_name" {
  type    = string
  default = "bucket-website-cloudfront"
}

variable "acl" {
  type    = string
  default = "public-read"
}