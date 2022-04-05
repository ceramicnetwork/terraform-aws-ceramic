provider "aws" {
  region = var.aws_region
}

provider "cloudflare" {
  # api_token = var.cloudflare_api_token # This can also be specified with the CLOUDFLARE_API_TOKEN shell environment variable.
}

provider "docker" {
  host = "http://registry.hub.docker.com"
}

module "ceramic_ecs" {
  source = "../../modules/ecs"

  count = var.deployments

  acm_certificate_arn            = var.acm_certificate_arn
  aws_region                     = var.aws_region
  base_namespace                 = "${var.cohort}-${count.index + 1}"
  ceramic_anchor_service_api_url = var.ceramic_anchor_service_api_url
  ceramic_cors_allowed_origins   = var.ceramic_cors_allowed_origins
  ceramic_env                    = var.ceramic_env
  ceramic_cpu                    = var.ceramic_cpu
  ceramic_eth_rpc_url            = var.ceramic_eth_rpc_url
  ceramic_efs_logs_fs_id         = var.ceramic_efs_logs_fs_id
  ceramic_efs_logs_fs_name       = var.ceramic_efs_logs_fs_name
  ceramic_memory                 = var.ceramic_memory
  ceramic_network                = var.ceramic_network
  ceramic_task_count             = var.ceramic_task_count
  ecs_cluster_name               = var.ecs_cluster_name
  env                            = var.env
  default_tags                   = var.default_tags
  image_tag                      = var.image_tag
  ipfs_cpu                       = var.ipfs_cpu
  ipfs_domain_name               = var.domain_name
  ipfs_enable_alb_logging        = var.ipfs_enable_alb_logging
  ipfs_memory                    = var.ipfs_memory
  ipfs_task_count                = var.ipfs_task_count
  private_subnet_ids             = var.private_subnet_ids
  public_subnet_ids              = var.public_subnet_ids
  s3_bucket_name                 = var.s3_bucket_name
  vpc_cidr_block                 = var.vpc_cidr_block
  vpc_id                         = var.vpc_id
  vpc_security_group_id          = var.vpc_security_group_id
}
