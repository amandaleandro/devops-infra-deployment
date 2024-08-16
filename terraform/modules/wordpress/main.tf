resource "aws_security_group" "wordpress_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_instance" "wordpress" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = [aws_security_group.wordpress_sg.name]

  tags = {
    Name = "WordPressInstance"
  }

  user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                yum install -y php php-mysqlnd
                service httpd start
                chkconfig httpd on
                cd /var/www/html
                wget https://wordpress.org/latest.tar.gz
                tar -xzvf latest.tar.gz
                cp -r wordpress/* .
                chown -R apache:apache /var/www/html
                # Configuração adicional do WordPress aqui, se necessário
                EOF
}

resource "aws_db_instance" "wordpress_db" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = "db.t2.micro"
  parameter_group_name = "default.mysql5.7"
  username             = "admin"
  password             = var.db_password

  tags = {
    Name = "wordpressdb"
  }
}

resource "aws_secretsmanager_secret" "wordpress_db_secret" {
  name = "wordpress_db_password"
}

resource "aws_secretsmanager_secret_version" "wordpress_db_secret_version" {
  secret_id     = aws_secretsmanager_secret.wordpress_db_secret.id
  secret_string = jsonencode({
    password = var.db_password
  })
}
