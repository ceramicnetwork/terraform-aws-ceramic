resource "aws_cloudwatch_log_group" "data_sync" {
  count             = var.enable_repo_backup_to_s3 ? 1 : 0
  name              = "/aws/datasync/${local.namespace}"
  retention_in_days = 1827
  tags              = local.default_tags

  lifecycle {
    prevent_destroy = true
  }
}
