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

#Windows Server 2022 Domain Controller 
resource "aws_instance" "windows_server" {
  ami           = "ami-005f8adf84f8c5057"
  instance_type = "t2.micro"

  tags = {
    Name = "Domain_Controller"

  }
  vpc_security_group_ids = [aws_security_group.Domain.id]
}

#Red Hat Enterprise Linux Ansible Server
resource "aws_instance" "rhel_server" {
  ami           = "ami-026ebd4cfe2c043b2"
  instance_type = "t2.micro"

  tags = {
    name = "Ansible_Server"
  }

  vpc_security_group_ids = [aws_security_group.Domain.id]
  user_data              = file("${path.module}/Ansible_Download.sh")
}

#Security Group for Servers
resource "aws_security_group" "Domain" {
  name    = "Servers"
  ingress = []
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}