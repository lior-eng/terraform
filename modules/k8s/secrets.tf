data "aws_secretsmanager_secret" "postgres_db_cred_secret" {
  arn = "arn:aws:secretsmanager:${var.region}:${var.account_id}:secret:${var.postgres_db_secret_name}"
}

data "aws_secretsmanager_secret_version" "postgresql_db_current" {
  secret_id = data.aws_secretsmanager_secret.postgres_db_cred_secret.id
}

resource "kubernetes_secret" "postgresql_secret" {

  metadata {
    name = "postgresql-secret"
  }

  data = {
    "postgres-password"       = jsondecode(data.aws_secretsmanager_secret_version.postgresql_db_current.secret_string)["postgres-user-password"]
    "postgres-admin-password" = ""
    "postgres-repl-password"  = ""
  }
}

data "aws_secretsmanager_secret" "argocd_ssh_key" {
  arn = "arn:aws:secretsmanager:${var.region}:${var.account_id}:secret:${var.argocd_ssh_secret_name}"
}

data "aws_secretsmanager_secret_version" "argocd_ssh_key_current" {
  secret_id = data.aws_secretsmanager_secret.argocd_ssh_key.id
}

resource "kubernetes_secret" "argocd_ssh_key" {
  depends_on = [helm_release.argocd]
  metadata {
    name      = "argocd-ssh-key"
    namespace = "argocd"

    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  data = {
    name          = "commercial-store"
    type          = "git"
    url           = var.repository_url
    sshPrivateKey = data.aws_secretsmanager_secret_version.argocd_ssh_key_current.secret_string
  }
}