resource "aws_instance" "myinstance1" {
  ami = var.my_ami
  instance_type = var.my_instance_type
  tags = {
    "Name"="Dev"
  }
}