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

  acm_certificate_arn            = data.aws_acm_certificate._3boxlabs_com.arn
  aws_region                     = var.aws_region
  base_namespace                 = "${var.cohort}-${count.index + 1}"
  ceramic_anchor_service_api_url = var.ceramic_anchor_service_api_url
  ceramic_cors_allowed_origins   = var.ceramic_cors_allowed_origins
  ceramic_env                    = var.ceramic_env
  ceramic_cpu                    = var.ceramic_cpu
  ceramic_eth_rpc_url            = data.aws_ssm_parameter.eth_rpc_url.value
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
  ipfs_default_log_level         = var.ipfs_default_log_level
  ipfs_memory                    = var.ipfs_memory
  ipfs_task_count                = var.ipfs_task_count
  private_subnet_ids             = data.aws_subnet_ids.private.ids
  public_subnet_ids              = data.aws_subnet_ids.public.ids
  s3_bucket_name                 = var.s3_bucket_name
  vpc_cidr_block                 = data.aws_vpc.main.cidr_block
  vpc_id                         = var.vpc_id
  vpc_security_group_id          = var.vpc_security_group_id
  existing_ipfs_peer             = var.existing_ipfs_peers
}

/*
 * Existing AWS resources (must be created beforehand).
 */

data "aws_acm_certificate" "_3boxlabs_com" {
  domain      = "*.${var.domain_name}"
  most_recent = true
}

data "aws_ssm_parameter" "eth_rpc_url" {
  name = "/ceramic-${var.env}/${lookup(var.eth_network, var.env)}/infura_rpc_endpoint"
}

data "aws_subnet_ids" "private" {
  vpc_id = var.vpc_id

  tags = {
    Ceramic = var.env
    Subnet  = "private"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = var.vpc_id

  tags = {
    Ceramic = var.env
    Subnet  = "public"
  }
}

data "aws_vpc" "main" {
  id = var.vpc_id
}
