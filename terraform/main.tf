provider "aws" {
  region     = "us-east-1"  # Substitua pela região onde deseja implantar os recursos
  access_key = var.aws_access_key_id  # Chave de acesso AWS
  secret_key = var.secret_access_key  # Chave secreta AWS
}

module "vpc" {
  source = "/modules/vpc"
}

module "ec2" {
  source = "/modules/ec2"
  vpc_id = module.vpc.vpc_id
}

module "eks" {
  source = "/modules/eks"
  vpc_id = module.vpc.vpc_id
}

module "rds" {
  source      = "/modules/rds"
  vpc_id      = module.vpc.vpc_id
  db_password = var.db_password
}

module "secrets_manager" {
  source = "modules/secrets"
  }

module "cdn" {
  source = "./modules/cdn"
}

module "observability" {
  source = "/modules/observability"
  instance_id = module.ec2.instance_id
}

module "auto_scaling" {
  source = "/modules/auto_scaling"
}

module "wordpress" {
  source    = "/modules/wordpress"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.ec2.public_subnet_id
  db_password = var.db_password
}

variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  default     = "your_default_password_here"  # Defina a senha do banco de dados aqui
}

module "lambda" {
  source = "/modules/lambda"
  cloudwatch_alarm_arn = module.cloudwatch.cloudwatch_alarm_arn
}