resource "aws_cloudwatch_log_group" "ceramic" {
  name              = "/ecs/${local.namespace}"
  retention_in_days = 400

  tags = local.default_tags
}
