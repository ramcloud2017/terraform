provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA4LRI4O6HSNGRQ7Y7"
  secret_key = "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"
}
resource "aws_instance" "my-server" {
  ami           = "ami-04bde106886a53080"
  instance_type = "t2.micro"

  tags = {
    Name = "ram-first-testserver"
  }
}
