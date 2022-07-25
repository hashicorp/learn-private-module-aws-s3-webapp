terraform {
    cloud { 
    organization = "tyreepearson"
    hostname ="app.terraform.io"
    workspaces {
      name = "terraform-aws-s3-webapp"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      
    }
}
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "bucket_for_s3_webapp" {
  bucket = "${var.prefix}-${var.name}"

  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_acl" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  acl = "public-read"
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.bucket.id
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
                "arn:aws:s3:::${aws_s3_bucket.bucket.id}/*"
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
  tags = {
    Name    = "S3-WebApp"
    Version = "1.0.1"
  }
}

resource "aws_s3_object" "webapp" {
  acl          = "public-read"
  key          = "index.html"
  bucket       = aws_s3_bucket.bucket.id
  content      = file("${path.module}/assets/index.html")
  content_type = "text/html"
}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.1.1"
  instance_type = var.instance_size
}