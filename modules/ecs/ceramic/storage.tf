provider "aws" {
  region = "eu-west-1" # eu-west-1 (Ireland) has same prices as us-east-2
  alias  = "replica"
}

module "s3_alb" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 1.25.0"

  create_bucket = true

  # only lowercase alphanumeric characters and hyphens allowed
  bucket = "${var.namespace}-alb"
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
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 1.25.0"

  create_bucket = true

  bucket = "${local.namespace}-module"
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
