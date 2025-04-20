resource "random_password" "master_password" {
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret" "aurora_secret" {
  name = var.secret_name
}

resource "aws_secretsmanager_secret_version" "aurora_secret_version" {
  secret_id     = aws_secretsmanager_secret.aurora_secret.id
  secret_string = jsonencode({
    username = var.username
    password = random_password.master_password.result
  })
}

resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = var.cluster_identifier
  engine                  = var.engine
  engine_version          = var.engine_version
  master_username         = var.username
  master_password         = random_password.master_password.result
  database_name           = var.db_name
 
  skip_final_snapshot     = true
}

resource "aws_rds_cluster_instance" "aurora_instances" {
  count              = 2
  identifier         = "${var.cluster_identifier}-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora.id
  instance_class     = var.instance_class
  engine             = var.engine
  publicly_accessible = false
}
