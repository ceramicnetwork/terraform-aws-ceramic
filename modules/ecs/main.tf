module "ceramic" {
  source = "./ceramic"

  acm_certificate_arn    = var.acm_certificate_arn
  anchor_service_api_url = var.ceramic_anchor_service_api_url
  aws_region             = var.aws_region
  base_tags              = var.default_tags
  ceramic_network        = var.ceramic_network
  cors_allowed_origins   = var.ceramic_cors_allowed_origins
  directory_namespace    = local.namespace
  ecs_cluster_name       = var.ecs_cluster_name
  ecs_service_name       = "${local.namespace}-node"
  ecs_count              = var.ceramic_task_count
  ecs_cpu                = var.ceramic_cpu
  efs_logs_fs_id         = var.ceramic_efs_logs_fs_id
  efs_logs_fs_name       = var.ceramic_efs_logs_fs_name
  ecs_log_group_name     = aws_cloudwatch_log_group.ceramic.name
  ecs_memory             = var.ceramic_memory
  env                    = var.env
  eth_rpc_url            = var.ceramic_eth_rpc_url
  image_tag              = var.image_tag
  ipfs_api_url           = module.ipfs.api_url_internal
  namespace              = "${local.namespace}-node"
  private_subnet_ids     = var.private_subnet_ids
  public_subnet_ids      = var.public_subnet_ids
  s3_bucket_arn          = data.aws_s3_bucket.main.arn
  s3_bucket_name         = data.aws_s3_bucket.main.id
  vpc_cidr_block         = var.vpc_cidr_block
  vpc_id                 = var.vpc_id
  vpc_security_group_id  = var.vpc_security_group_id
}

module "ipfs" {
  source = "./ipfs"

  acm_certificate_arn     = var.acm_certificate_arn
  aws_region              = var.aws_region
  base_tags               = var.default_tags
  base_namespace          = local.namespace
  directory_namespace     = local.namespace
  domain                  = var.ipfs_domain_name
  ecs_cluster_name        = var.ecs_cluster_name
  ecs_service_name        = "${local.namespace}-ipfs-nd"
  ecs_count               = var.ipfs_task_count
  ecs_cpu                 = var.ipfs_cpu
  ecs_log_group_name      = aws_cloudwatch_log_group.ceramic.name
  ecs_memory              = var.ipfs_memory
  enable_alb_logging      = var.ipfs_enable_alb_logging
  enable_external_api     = false
  enable_internal_api     = true
  enable_external_gateway = false
  enable_internal_gateway = false
  enable_pubsub           = true
  env                     = var.env
  image_tag               = var.image_tag
  namespace               = "${local.namespace}-ipfs-nd"
  private_subnet_ids      = var.private_subnet_ids
  public_subnet_ids       = var.public_subnet_ids
  s3_bucket_arn           = data.aws_s3_bucket.main.arn
  s3_bucket_name          = data.aws_s3_bucket.main.id
  use_s3_blockstore       = true
  use_ssl                 = true
  vpc_cidr_block          = var.vpc_cidr_block
  vpc_id                  = var.vpc_id
  vpc_security_group_id   = var.vpc_security_group_id
  efs_security_group_id   = module.ceramic.efs_security_group_id
}

resource "aws_cloudwatch_log_group" "ceramic" {
  name              = "/ecs/${local.namespace}"
  retention_in_days = 400
  tags              = var.default_tags
}

data "aws_s3_bucket" "main" {
  bucket = var.s3_bucket_name
}
