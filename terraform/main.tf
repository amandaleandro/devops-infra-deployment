provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source = "./modules/ec2"
  vpc_id = module.vpc.vpc_id
}

module "eks" {
  source = "./modules/eks"
  vpc_id = module.vpc.vpc_id
}

module "rds" {
  source      = "./modules/rds"
  vpc_id      = module.vpc.vpc_id
  db_password = var.db_password
}

module "secrets_manager" {
  source             = "./modules/secrets"
  db_password        = var.db_password
  aws_access_key_id  = "your_aws_access_key_id_here"
  secret_access_key  = "your_secret_access_key_here"
}

variable "secret_access_key" {
  description = "Secret access key for AWS"
  type        = string
  default     = "your_default_secret_access_key_here"
}

module "cdn" {
  source = "./modules/cdn"
}

module "observability" {
  source = "./modules/observability"
}

module "auto_scaling" {
  source = "./modules/auto_scaling"
}

module "wordpress" {
  source    = "./modules/wordpress"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.ec2.public_subnet_id
  db_password = var.db_password
}

variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  default     = "your_default_password_here"  # Defina a senha do banco de dados aqui
}

