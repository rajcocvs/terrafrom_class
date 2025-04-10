terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.00.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


module "my-ec2_mod" {
  source = "./modules/EC2"
  my_ami = var.my-ami-1
  my_instance_type = var.my_instance_type1
}