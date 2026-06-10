# DATABASE_URL is assembled here and injected into the ECS task via the
# `secrets` block — never as a plain env var. Rotation is manual for now.
resource "aws_secretsmanager_secret" "database_url" {
  name        = "${local.name_prefix}/database_url"
  description = "Postgres connection string for the app."

  # Forces a new secret on destroy/recreate instead of waiting out the
  # default 30-day recovery window. Fine for dev; raise for prod.
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "database_url" {
  secret_id = aws_secretsmanager_secret.database_url.id
  secret_string = format(
    "postgres://%s:%s@%s:%d/%s",
    var.db_username,
    random_password.db.result,
    aws_db_instance.main.address,
    aws_db_instance.main.port,
    var.db_name,
  )
}
