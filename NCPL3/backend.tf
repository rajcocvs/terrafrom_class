terraform {
  backend "s3" {
    bucket         = "ncplrajcoterraform2" # change this
    key            = "rajco/terraform.tfstate"
    region         = "us-east-1"
  }
}