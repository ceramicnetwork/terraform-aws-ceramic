module "ceramic" {
  source = "../../modules/ecs/ceramic"

  aws_region            = var.aws_region
  cors_allowed_origins  = var.ceramic_cors_allowed_origins
  namespace             = "${var.base_namespace}-elp-ceramic"
  network               = var.ceramic_network
  service_subnet_ids    = var.ceramic_service_subnet_ids
  eth_rpc_url           = var.ceramic_eth_rpc_url
  anchor_service_api_url = var.ceramic_anchor_service_api_url
  private_subnet_ids    = var.private_subnet_ids
  ssl_certificate_arn   = var.ceramic_certificate_arn
  vpc_security_group_id = var.vpc_security_group_id
  vpc_id                = var.vpc_id
  env                   = "elp"
  vpc_cidr_block        = var.vpc_cidr_block

  # Creates
  # create_ceramic_efs_volume = true
  # create_cluster = true
  # create_ceramic_service = true

  # Dependencies
  alb_subnet_ids = var.ceramic_alb_subnet_ids

  # Optional
  # ceramic_cpu = 1024
  # ceramic_efs_logs_volume_id = ""
  image_tag = "latest"
  # ceramic_load_balancer_contents = []
  # ceramic_memory = 2048
  cluster_name = var.ceramic_cluster_name
  # ceramic_port = 7007
  # service_name = "ceramic-daemon"
  # ceramic_service_security_group_ids = []
  # ceramic_task_count = 1
  default_tags = {
    Terraform = "true"
    Ceramic = "elp"
  }
  # load_balancer_arn = ""
  run_as_gateway = false
}

# module "ipfs" {
#   source = "../../modules/ecs/ipfs"
# 
#   acm_certificate_arn         = var.ipfs_certificate_arn
#   aws_region                  = var.aws_region
#   az_count                    = var.az_count
#   base_namespace              = var.base_namespace
#   base_tags                   = local.default_tags
#   create_s3_backend           = false
#   debug                       = var.ipfs_debug
#   dht_server_mode             = false
#   domain                      = ""
#   enable_external_api         = false
#   enable_internal_api         = true
#   enable_external_gateway     = false
#   enable_internal_gateway     = true
#   enable_internal_swarm       = true
#   enable_pubsub               = true
#   env                         = var.env
#   ecs_cluster_arn             = aws_ecs_cluster.main.arn
#   ecs_task_execution_role_arn = var.ecs_task_execution_role_arn
#   ecs_count                   = var.ipfs_count
#   ecs_cpu                     = var.ipfs_cpu
#   ecs_memory                  = var.ipfs_ecs_memory
#   ecs_log_group_name          = aws_cloudwatch_log_group.main.name
#   ecs_log_stream_prefix       = "ipfs"
#   private_subnet_ids    = var.private_subnet_ids
#   public_subnet_ids           = var.public_subnet_ids
#   s3_bucket_arn               = module.s3_cas.this_s3_bucket_arn
#   s3_bucket_id                = module.s3_cas.this_s3_bucket_id
#   s3_replica_arn              = "" # not applicable
#   s3_replication_role_arn     = "" # not applicable
#   subdomain_namespace         = "cas"
#   use_ssl                     = true
#   vpc_cidr_block              = var.vpc_cidr_block
#   vpc_id                      = var.vpc_id
#   vpc_security_group_id       = var.vpc_security_group_id
# }