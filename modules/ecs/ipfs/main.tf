resource "aws_ecs_service" "main" {
  platform_version = "1.4.0"
  name             = var.ecs_service_name
  cluster          = var.ecs_cluster_name
  task_definition  = aws_ecs_task_definition.main.arn
  desired_count    = var.ecs_count
  launch_type      = "FARGATE"

  network_configuration {
    security_groups = [
      aws_security_group.alb_external.id,
      aws_security_group.alb_internal.id,
      module.api_security_group.this_security_group_id
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

  depends_on = [
    aws_lb.external,
    aws_security_group.alb_external
  ]

  lifecycle {
    ignore_changes = [desired_count]
  }
}

resource "aws_ecs_task_definition" "main" {
  family = local.namespace
  container_definitions = templatefile(
    "${path.module}/templates/container_definitions.json.tpl",
    {
      cpu               = var.ecs_cpu
      env               = var.env
      image             = data.docker_registry_image.ipfs.name
      log_group         = var.ecs_log_group_name
      log_stream_prefix = var.ecs_log_prefix
      memory            = var.ecs_memory
      region            = var.aws_region

      ceramic_network     = var.ceramic_network
      enable_api          = true
      enable_gateway      = true
      enable_pubsub       = var.enable_pubsub

      api_port              = local.api_port
      gateway_port          = local.gateway_port
      healthcheck_port      = local.healthcheck_port
      swarm_ws_port         = local.swarm_ws_port
      announce_address_list = local.announce_address_list
      dht_server_mode       = var.dht_server_mode
      debug                 = var.debug

      s3_bucket_name       = var.s3_bucket_name
      s3_access_key_id     = module.ecs_ipfs_task_user.this_iam_access_key_id
      s3_secret_access_key = module.ecs_ipfs_task_user.this_iam_access_key_secret
      ipfs_path            = var.directory_namespace != "" ? "${var.directory_namespace}/ipfs" : "ipfs" 
      root_backend         = var.root_backend
      blocks_backend       = var.blocks_backend
      keys_backend         = var.keys_backend
      pins_backend         = var.pins_backend
      datastore_backend    = var.datastore_backend
    }
  )

  execution_role_arn = module.ecs_task_execution_role.this_iam_role_arn
  task_role_arn      = module.ecs_ipfs_task_role.this_iam_role_arn
  network_mode       = "awsvpc"

  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_cpu
  memory                   = var.ecs_memory

  tags = local.default_tags
}

data "aws_ecs_cluster" "main" {
  cluster_name = var.ecs_cluster_name
}
