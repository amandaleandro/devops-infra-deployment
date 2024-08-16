variable "vpc_id" {
  description = "ID of the VPC"
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0" # Substitua pelo ID da AMI apropriada
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "WebInstance"
  }

  user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                service httpd start
                chkconfig httpd on
                EOF
}

resource "aws_subnet" "public" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}
