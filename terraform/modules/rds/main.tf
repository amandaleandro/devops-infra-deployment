variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "db_password" {
  description = "Password for the RDS database"
  type        = string
}

resource "aws_secretsmanager_secret" "rds_secret" {
  name        = "rds_password"
  description = "Password for the RDS database"
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id     = aws_secretsmanager_secret.rds_secret.id

  secret_string = jsonencode({
    password = var.db_password
  })
}

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = "db.t2.micro"
  username             = "admin"
  password             = jsondecode(aws_secretsmanager_secret_version.rds_secret_version.secret_string)["password"]
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.default.name

  tags = {
    Name = "WordPressDB"
    name = "wordpressdb"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "default"
  subnet_ids = [aws_subnet.public.id, aws_subnet.private.id]

  tags = {
    Name = "default"
  }
}

resource "aws_security_group" "rds_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
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
