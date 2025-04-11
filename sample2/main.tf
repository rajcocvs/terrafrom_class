
/* # Static Security Group without dynamic block
resource "aws_security_group" "web_sg" {
  name        = "web-sg-static"
  description = "Security group with static ingress rules"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
} */
# Define region and other variables





# Fetch subnets in the default VPC using filter
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Security Group with dynamic ingress rules
resource "aws_security_group" "web_sg" {
  name        = "web-sg-dynamic"
  description = "Security group with dynamic ingress rules"
  vpc_id      = data.aws_vpc.default.id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch EC2 instance using the first subnet from the dynamic block
resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnets.default.ids[0]  # Accessing the first subnet ID from the list
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "EC2-with-Dynamic-SG"
  }

 depends_on = [ aws_security_group.web_sg ]
}