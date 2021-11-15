terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}


resource "aws_s3_bucket" "arun-terraform-test-bucket" {
  bucket = "arun-terraform-test-bucket"
  acl    = "private"

  tags = {
    Name        = "Arun first bucket"
      }
}
