module "ceramic" {
  source = "../../modules/ecs/ceramic"

  aws_region            = var.aws_region
  cors_allowed_origins  = var.ceramic_cors_allowed_origins
  namespace             = "${var.base_namespace}-elp-ceramic"
  network               = var.ceramic_network
  eth_rpc_url           = var.ceramic_eth_rpc_url
  anchor_service_api_url = var.ceramic_anchor_service_api_url
  private_subnet_ids    = var.private_subnet_ids
  ssl_certificate_arn   = var.ssl_certificate_arn
  vpc_security_group_id = var.vpc_security_group_id
  vpc_id                = var.vpc_id
  env                   = var.env
  vpc_cidr_block        = var.vpc_cidr_block

  # Creates
  # create_ceramic_efs_volume = true
  # create_cluster = true

  # Dependencies
  alb_subnet_ids = var.public_subnet_ids

  # Optional
  ecs_cpu = var.ceramic_cpu
  # ceramic_efs_logs_volume_id = ""
  image_tag = "latest"
  # ceramic_load_balancer_contents = []
  # ceramic_memory = 2048
  cluster_name = var.cluster_name
  # ceramic_port = 7007
  # service_name = "ceramic-daemon"
  # ceramic_service_security_group_ids = []
  task_count = var.ceramic_task_count
  default_tags = var.default_tags
  # load_balancer_arn = ""
  run_as_gateway = false
}

module "ipfs" {
  source = "../../modules/ecs/ipfs"

  acm_certificate_arn         = var.ssl_certificate_arn
  aws_region                  = var.aws_region
  az_count                    = var.az_count
  base_namespace              = var.base_namespace
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
  ecs_cluster_name            = var.cluster_name
  ecs_count                   = var.ipfs_task_count
  ecs_cpu                     = var.ipfs_cpu
  ecs_memory                  = var.ipfs_ecs_memory
  ecs_log_group_name          = var.ipfs_log_group_name
  ecs_log_stream_prefix       = var.ipfs_log_stream_prefix
  private_subnet_ids          = var.private_subnet_ids
  public_subnet_ids           = var.public_subnet_ids
  use_ssl                     = true
  vpc_cidr_block              = var.vpc_cidr_block
  vpc_id                      = var.vpc_id
  vpc_security_group_id       = var.vpc_security_group_id
}