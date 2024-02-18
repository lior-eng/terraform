data "aws_secretsmanager_secret" "postgres_db_cred_secret" {
  arn = "arn:aws:secretsmanager:us-east-1:644435390668:secret:postgres-secret-UWgQIy"
}

data "aws_secretsmanager_secret_version" "postgresql_db_current" {
  secret_id = data.aws_secretsmanager_secret.postgres_db_cred_secret.id
}

resource "kubernetes_secret" "postgresql_secret" {

  metadata {
    name = "postgresql-secret"
  }

  data = {
    "postgres-user-password"  = jsondecode(data.aws_secretsmanager_secret_version.postgresql_db_current.secret_string)["postgres-user-password"]
    "postgres-admin-password" = jsondecode(data.aws_secretsmanager_secret_version.postgresql_db_current.secret_string)["postgres-admin-password"]
    "postgres-repl-password"  = jsondecode(data.aws_secretsmanager_secret_version.postgresql_db_current.secret_string)["postgres-repl-password"]
    "database"                = jsondecode(data.aws_secretsmanager_secret_version.postgresql_db_current.secret_string)["database"]
  }
}