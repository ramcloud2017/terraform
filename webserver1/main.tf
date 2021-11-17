terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  shared_credentials_file = "var.creds_path.var.creds_file"
  profile = "default"
}

# Create a VPC
resource "aws_vpc" "app_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "app-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name = "vpc_igw"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table_association" "public_rt_asso" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "key-name"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzMN4FHIfmm6RlKeL7A6ABXNmmXWJotKgk599P4wANeii1+nMGQjeu1ygoCHsjbRfbe5pITFwZ/g8d7hSm9wtnYRxrxRPRW0aVD46IMuYrTfD+McdGiQAK8RlecQA4mZR4wo7ASvcs10lemFVVCGHV5IBD6nH0W7X/zBLKgiG0GTQYqm/Jrz3nsmmo2pD4sZYFNCjbZJEN99nHbpnsqRF1lIJYyvU+v5+g2Q/wMK/fTC38MWi43chce4WqjYdRZTxnxh+CUPSzNo/Bj5IL613OLHgb/c37DaICJUWHcKMNWvGPJIjCHd1AV3EH64m3r6LZT+gRNY6KTw2AUtZifOZFk0HE3w+346cav1LLDNW1s0YnrXJ9SK3NzNCv3dsxpdGfY3Ai7DxC4a3q8DpooSG+GOEuHGxMF/vnPH95oinrFxL7KY9tFgHwFdbeen6QdjSqbZJtuPgkBTCEg6UNMpZ2hCiHyo8YxMAtVbT76m/gafTOl7AcgRZhMyqAF6fIqak= Minion1@DESKTOP-NIQLBLT"
}

resource "aws_instance" "web" {
  ami           = "ami-0ba0f49e823b50d7f" 
  instance_type = var.instance_type
  #key_name        = var.instance_key
  subnet_id      = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.sg.id]

  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  echo "*** Completed Installing apache2"
  EOF

  tags = {
    Name = "web_instance"
  }

  volume_tags = {
    Name = "web_instance"
  } 
}
