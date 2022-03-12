module "s3_alb" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "1.25.0"

  create_bucket = var.enable_alb_logging

  bucket = "${local.namespace}-alb.logs"
  acl    = "private"

  attach_elb_log_delivery_policy = true

  lifecycle_rule = [
    {
      enabled = true
      expiration = {
        days = 60
      }
    }
  ]

  tags = local.default_tags
}
