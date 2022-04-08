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

module "efs_repo_volume" {
  source = "git::https://github.com/cloudposse/terraform-aws-efs.git?ref=0.22.0"

  name      = "repo"
  namespace = "${local.namespace}-repo"

  region  = var.aws_region
  subnets = var.private_subnet_ids
  security_groups = [
    var.efs_security_group_id,
    var.vpc_security_group_id,
    module.api_security_group.security_group_id
  ]
  vpc_id = var.vpc_id

  tags = local.default_tags
}
