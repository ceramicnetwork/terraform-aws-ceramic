resource "aws_cloudwatch_log_group" "ceramic" {
  name              = "/ecs/${local.namespace}"
  retention_in_days = 1827
  tags              = var.default_tags

  lifecycle {
    prevent_destroy = true
  }
}
