# Learn Module Use from Github 

This module is for learning purposes and has not been tested for "production."

## How To Use
- Enter the following code in your root directory main.tf file
- Make sure to specify a unique bucket name in the module block

~~~
module "website_s3_bucket" {
  source = "github.com/Keimille/terraform-aws-s3webapp"

  bucket_name = "<UNIQUE BUCKET NAME>"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

~~~

- Run terrafrom init
