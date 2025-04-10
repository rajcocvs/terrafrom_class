terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "my_ami" {
    description = "This to define my ami"
    default = "ami-00a929b66ed6e0de6"
  
}

 variable "my_instance_type" {
   description = "This to define my ami"
    default = "t2.micro"
 }


resource "aws_instance" "myinstance1" {
  ami = var.my_ami
  instance_type = var.my_instance_type
  tags = {
    "Name"="Dev"
  }
}
output "name" {
  value = aws_instance.myinstance1.private_ip
}