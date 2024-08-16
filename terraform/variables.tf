variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}
variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  default     = "your_default_password_here"  # Defina a senha do banco de dados aqui
}

variable "version" {
  description = "Version of the deployment"
  type        = string
  default     = "1.0.0"
}

variable "aws_access_key_id" {
  description = "AWS access key ID"
  type        = string
}

variable "secret_access_key" {
  description = "AWS secret access key"
  type        = string
}