provider "aws" {
  region = var.aws_region
}

module "ceramic" {
  source = "./ceramic"

  aws_region             = var.aws_region
  cors_allowed_origins   = var.ceramic_cors_allowed_origins
  namespace              = "ceramic-${var.env}-${var.base_namespace}"
  network                = var.env
  eth_rpc_url            = var.ceramic_eth_rpc_url
  anchor_service_api_url = var.ceramic_anchor_service_api_url
  private_subnet_ids     = var.private_subnet_ids
  ssl_certificate_arn    = var.ssl_certificate_arn
  vpc_security_group_id  = var.vpc_security_group_id
  vpc_id                 = var.vpc_id
  env                    = var.env
  vpc_cidr_block         = var.vpc_cidr_block
  efs_logs_fs_id         = var.ceramic_efs_logs_fs_id
  efs_logs_volume_name   = var.ceramic_efs_logs_volume_name
  ecs_log_group_name     = aws_cloudwatch_log_group.ceramic.name
  public_subnet_ids      = var.public_subnet_ids
  ecs_cpu                = var.ceramic_cpu
  image_tag              = var.image_tag
  ecs_cluster_name       = var.ecs_cluster_name
  service_name           = "ceramic-${var.env}-${var.base_namespace}-node"
  task_count             = var.ceramic_task_count
  default_tags           = var.default_tags
}

module "ipfs" {
  source = "./ipfs"

  acm_certificate_arn         = var.ssl_certificate_arn
  aws_region                  = var.aws_region
  az_count                    = var.az_count
  namespace                   = "ceramic-${var.env}-${var.base_namespace}-ipfs"
  base_tags                   = var.default_tags
  debug                       = true
  dht_server_mode             = false
  domain                      = ""
  enable_external_api         = false
  enable_internal_api         = true
  enable_external_gateway     = false
  enable_internal_gateway     = true
  enable_internal_swarm       = true
  enable_pubsub               = true
  env                         = var.env
  ecs_cluster_name            = var.ecs_cluster_name
  ecs_service_name            = "ceramic-${var.env}-${var.base_namespace}-ipfs"
  ecs_count                   = var.ipfs_task_count
  ecs_cpu                     = var.ipfs_cpu
  ecs_memory                  = var.ipfs_ecs_memory
  ecs_log_group_name          = aws_cloudwatch_log_group.ceramic.name
  image_tag                   = var.image_tag
  private_subnet_ids          = var.private_subnet_ids
  public_subnet_ids           = var.public_subnet_ids
  use_ssl                     = true
  vpc_cidr_block              = var.vpc_cidr_block
  vpc_id                      = var.vpc_id
  vpc_security_group_id       = var.vpc_security_group_id
}

resource "aws_cloudwatch_log_group" "ceramic" {
  name              = "/ecs/ceramic-${var.env}-${var.base_namespace}"
  retention_in_days = 400
  tags              = var.default_tags
}
