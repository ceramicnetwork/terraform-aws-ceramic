provider "aws" {
  region = "eu-west-1" # eu-west-1 (Ireland) has same prices as us-east-2

  alias = "replica"
}

module "efs_logs_volume" {
  source = "cloudposse/efs/aws"

  name      = "logs"
  namespace = var.namespace

  region  = var.aws_region
  subnets = var.private_subnet_ids
  security_groups = [
    aws_security_group.efs.id,
    var.vpc_security_group_id,
    module.ceramic_security_group.security_group_id,
    module.ecs_security_group.security_group_id
  ]
  vpc_id = var.vpc_id

  tags = var.default_tags
}

data "aws_efs_file_system" "by_id" {
  file_system_id = var.create_ceramic_efs_volume ? module.efs_logs_volume.id : var.ceramic_efs_logs_volume_id
}

module "s3_alb" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 1.25.0"

  create_bucket = true

  # only lowercase alphanumeric characters and hyphens allowed
  bucket = "${var.namespace}-alb.logs"
  acl    = "private"

  attach_elb_log_delivery_policy = true

  versioning = {
    enabled = true
  }

  lifecycle_rule = [
    {
      enabled = true

      noncurrent_version_expiration = {
        days = 30
      }
    }
  ]

  tags = var.default_tags
}

module "s3" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 1.25.0"

  create_bucket = true

  bucket = "${local.namespace}"
  acl    = "private"

  versioning = {
    enabled = true
  }

  lifecycle_rule = [
    {
      enabled = true

      noncurrent_version_expiration = {
        days = 30
      }
    }
  ]
}

data "aws_s3_bucket" "alb" {
  bucket = module.s3_alb.this_s3_bucket_id
}
