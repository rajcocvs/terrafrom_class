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

resource "aws_instance" "myinstance1" {
  ami = "ami-00a929b66ed6e0de6"
  instance_type = "t2.micro"
  tags = {
    "Name"="Dev"
  }
}

resource "aws_s3_bucket" "bucket1" {
    bucket = "ncplrajcoterraform1"

     
}