output "endpoint" {
  value = aws_s3_bucket.bucket.website_endpoint
}
output "instance_state"{
  value = module.ec2-instance.instance_state
}