module "ceramic-ecs" {
  source = "../../modules/ecs"

  env                   = var.env
  aws_region            = var.aws_region
  az_count              = var.az_count
  private_subnet_ids    = var.private_subnet_ids
  public_subnet_ids     = var.public_subnet_ids
  ssl_certificate_arn   = var.ssl_certificate_arn
  vpc_security_group_id = var.vpc_security_group_id
  vpc_id                = var.vpc_id
  vpc_cidr_block        = var.vpc_cidr_block
  ecs_cluster_name      = var.ecs_cluster_name
  image_tag             = var.image_tag
  base_namespace        = var.base_namespace
  default_tags          = var.default_tags

  ceramic_cors_allowed_origins   = var.ceramic_cors_allowed_origins
  ceramic_eth_rpc_url            = var.ceramic_eth_rpc_url
  ceramic_anchor_service_api_url = var.ceramic_anchor_service_api_url
  ceramic_efs_logs_fs_id         = var.ceramic_efs_logs_fs_id
  ceramic_efs_logs_volume_name   = var.ceramic_efs_logs_volume_name
  ceramic_cpu                    = var.ceramic_cpu
  ceramic_task_count             = var.ceramic_task_count

  ipfs_task_count = var.ipfs_task_count
  ipfs_ecs_memory = var.ipfs_ecs_memory
}
