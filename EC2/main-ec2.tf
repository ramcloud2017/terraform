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


resource "aws_instance" "arun_app_server" {
  ami           = "ami-0ba0f49e823b50d7f"
  instance_type = "t2.micro"

  tags = {
    Name = "Arun Sample AppServer Instance"
  }
}


