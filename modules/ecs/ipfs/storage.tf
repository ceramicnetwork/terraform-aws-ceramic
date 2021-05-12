module "s3_ipfs" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 1.25.0"

  create_bucket = true

  bucket = "${local.namespace}-module"
  acl    = "private"

  versioning = {
    enabled = true
  }

  lifecycle_rule = local.s3_lifecycle_rules

  tags = local.default_tags
}

module "s3_alb" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 1.25.0"

  create_bucket = true

  bucket = "${local.namespace}-alb"
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
