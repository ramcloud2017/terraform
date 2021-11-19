provider "aws" {
  region = "ap-south-1"
  access_key = ""
  secret_key = ""
}

resource "aws_s3_bucket" "tf-marks-bucket" {
  bucket = "tf-marks-bucket"
  acl    = "private"

}
