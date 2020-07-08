provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "this_bucket" {
  bucket = var.name
  acl    = "public-read"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.name}/*"
            ]
        }
    ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "error.html"

  }
  force_destroy = true
}

resource "aws_s3_bucket_object" "example" {

  for_each = fileset("${path.module}/assets", "**")

  bucket = aws_s3_bucket.this_bucket.bucket
  key    = each.value
  content_type = "text/html"
  acl          = "public-read"
  source = "${path.module}/assets/${each.value}"


}

#resource "aws_s3_bucket_object" "error" {
#  acl          = "public-read"
#  key          = "error.html"
#  bucket       = aws_s3_bucket.bucket.id
#  content      = file("${path.module}/assets/error.html")
#  content_type = "text/html"

#}
