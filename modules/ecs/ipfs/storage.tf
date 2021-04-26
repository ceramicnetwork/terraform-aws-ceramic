module "s3_ipfs" {
  source = "terraform-aws-modules/s3-bucket/aws"

  create_bucket = var.create_s3_backend

  bucket = "${local.namespace}-module"
  acl    = "private"

  versioning = {
    enabled = true
  }

  lifecycle_rule = local.s3_lifecycle_rules

  replication_configuration = {
    role = var.s3_replication_role_arn

    rules = [
      {
        id       = "0"
        status   = "Enabled"
        priority = 0
        destination = {
          bucket        = var.s3_replica_arn
          storage_class = "STANDARD_IA"
        }
      }
    ]
  }

  tags = local.default_tags
}

module "s3_alb" {
  source = "terraform-aws-modules/s3-bucket/aws"

  create_bucket = true

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
