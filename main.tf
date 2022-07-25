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
      source = "hashicorp/aws"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
  }
  
  
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "bucket_for_s3_webapp" {
  bucket = "${var.prefix}-${var.name}"
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
                "arn:aws:s3:::${var.prefix}-${var.name}/*"
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

resource "aws_s3_bucket_object" "webapp" {
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