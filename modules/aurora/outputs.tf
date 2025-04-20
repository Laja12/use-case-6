output "rds_cluster_endpoint" {
  value = aws_rds_cluster.aurora.endpoint
}

output "rds_cluster_reader_endpoint" {
  value = aws_rds_cluster.aurora.reader_endpoint
}

output "secret_arn" {
  value = aws_secretsmanager_secret.aurora_secret.arn
}
