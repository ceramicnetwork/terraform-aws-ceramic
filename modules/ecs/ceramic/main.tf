resource "aws_ecs_service" "main" {
  platform_version = "1.4.0"
  name             = var.ecs_service_name
  cluster          = var.ecs_cluster_name
  task_definition  = aws_ecs_task_definition.main.arn
  desired_count    = var.ecs_count
  launch_type      = "FARGATE"

  network_configuration {
    security_groups = [
      var.vpc_security_group_id,
      aws_security_group.efs.id,
      module.ceramic_security_group.security_group_id
    ]
    subnets = var.private_subnet_ids
  }
  dynamic "load_balancer" {
    for_each = local.dynamic_load_balancers
    content {
      target_group_arn = load_balancer.value["target_group_arn"]
      container_name   = load_balancer.value["container_name"]
      container_port   = load_balancer.value["container_port"]
    }
  }

  tags = local.default_tags

  lifecycle {
    ignore_changes = [desired_count]
  }
}

resource "aws_ecs_task_definition" "main" {
  family = local.namespace
  container_definitions = templatefile("${path.module}/templates/container_definitions.json.tpl", {
    anchor_service_api_url     = var.anchor_service_api_url
    ceramic_image              = data.docker_registry_image.ceramic.name
    ceramic_network            = var.ceramic_network
    ceramic_port               = var.ceramic_port
    container_name             = local.container_name
    cors_allowed_origins       = var.cors_allowed_origins
    cpu                        = var.ecs_cpu
    debug                      = var.ceramic_enable_debug
    directory_namespace        = var.directory_namespace
    env                        = var.env
    eth_rpc_url                = var.eth_rpc_url
    ipfs_api_url               = var.ipfs_api_url
    log_group                  = var.ecs_log_group_name
    log_stream_prefix          = var.ecs_log_prefix
    logs_volume_source         = var.efs_logs_fs_name
    memory                     = var.ecs_memory
    region                     = var.aws_region
    s3_state_store_bucket_name = var.s3_bucket_name
    s3_access_key_id           = module.s3_ceramic_state_store_task_user.this_iam_access_key_id
    s3_secret_access_key       = module.s3_ceramic_state_store_task_user.this_iam_access_key_secret
    verbose                    = var.enable_verbose
  })

  execution_role_arn = module.ecs_task_execution_role.this_iam_role_arn
  task_role_arn      = module.ecs_efs_task_role.this_iam_role_arn
  network_mode       = "awsvpc"

  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_cpu
  memory                   = var.ecs_memory

  volume {
    name = var.efs_logs_fs_name
    efs_volume_configuration {
      file_system_id = var.efs_logs_fs_id
    }
  }

  tags = local.default_tags
}

data "aws_ecs_cluster" "main" {
  cluster_name = var.ecs_cluster_name
}
