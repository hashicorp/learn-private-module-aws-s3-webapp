output "endpoint" {
  value = aws_s3_bucket.bucket.website_endpoint
}
output "acl" {
  value = aws_s3_bucket.bucket.acl
}
