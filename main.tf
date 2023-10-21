terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.22"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "windows_server" {
  ami           = "ami-005f8adf84f8c5057"
  instance_type = "t2.micro"

  tags = {
    Name = "Example_TerraformServer"
  }
}