provider "aws" {
  region = "eu-west-1" # eu-west-1 (Ireland) has same prices as us-east-2

  alias = "replica"
}

module "efs_logs_volume" {
  source = "git::https://github.com/cloudposse/terraform-aws-efs.git?ref=0.22.0"

  name      = "logs"
  namespace = var.ceramic_namespace

  region  = var.aws_region
  subnets = var.private_subnet_ids
  security_groups = [
    var.efs_security_group_id,
    var.vpc_security_group_id,
    module.ceramic_security_group.this_security_group_id,
    module.ecs_security_group.this_security_group_id
  ]
  vpc_id = var.vpc_id

  tags = var.default_tags
}

data "aws_efs_file_system" "by_id" {
  file_system_id = var.create_ceramic_efs_volume ? module.efs_logs_volume.id : var.ceramic_efs_logs_volume_id
}

module "s3_alb" {
  source = "terraform-aws-modules/s3-bucket/aws"

  create_bucket = var.create_ceramic_alb_access_logs_bucket

  # only lowercase alphanumeric characters and hyphens allowed
  bucket = "${var.ceramic_namespace}-alb.logs"
  acl    = "private"

  attach_elb_log_delivery_policy = true

  versioning = {
    enabled = true
  }

  lifecyle_rule = [
    {
      enabled = true

      noncurrent_version_expiration = {
        days = 30
      }
    }
  ]

  tags = var.default_tags
}

data "aws_s3_bucket" "alb" {
  bucket = var.create_ceramic_alb_access_logs_bucket ? module.s3_alb.this_s3_bucket_id : var.ceramic_alb_access_logs_bucket_id
}
