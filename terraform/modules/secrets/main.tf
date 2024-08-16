resource "random_password" "db_password" {
  length  = 16
  special = true
}

resource "random_password" "aws_access_key_id" {
  length  = 20
  special = true
}

resource "random_password" "sec_access_key" {
  length  = 20
  special = true
}

resource "aws_secretsmanager_secret" "secret_master" {
  name = "master_secret"
}

resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id     = aws_secretsmanager_secret.secret_master.id
  secret_string = jsonencode({
    dbPassword      = random_password.db_password.result
    awsSecretAccess = random_password.aws_access_key_id.result
    secretAccessKey = random_password.sec_access_key.result
  })
}
