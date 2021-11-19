provider "aws" {
  region = "ap-south-1"
  access_key = "AKIA4LRI4O6HSNGRQ7Y7"
  secret_key = "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"
}

resource "aws_s3_bucket" "tf-marks-bucket" {
  bucket = "tf-marks-bucket"
  acl    = "private"

}