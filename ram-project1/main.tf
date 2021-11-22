provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}
resource "aws_instance" "my-server" {
  ami           = "ami-04bde106886a53080"
  instance_type = "t2.micro"

  tags = {
    Name = "ram-first-testserver"
  }
}
