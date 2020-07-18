terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "jade101"
    workspaces {
      name = "terraform-aws-s3-webapp"
    }
  }
}