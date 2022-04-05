locals {
  namespace = var.namespace
  default_tags = merge(var.base_tags, {
    IPFS = true
  })
  api_port         = 5011
  gateway_port     = 9011
  healthcheck_port = 8011
  swarm_tcp_port   = 4010
  # TODO: Choose between 4011 and 4012 based on `use_ssl` once `go-ipfs` supports WSS
  # swarm_ws_port  = var.use_ssl ? 4012 : 4011
  swarm_ws_port    = 4011

  announce_address_list = var.use_ssl ? "/dns4/${local.domain_name_external}/tcp/${local.swarm_ws_port}/ws,/dns4/${local.domain_name_external}/tcp/${local.swarm_tcp_port}" : "/dns4/${aws_lb.external.dns_name}/tcp/${local.swarm_ws_port}/ws,/dns4/${aws_lb.external.dns_name}/tcp/${local.swarm_tcp_port}"
  domain_name_external  = "ipfs-${var.base_namespace}-external.${var.domain}"
  domain_name_internal  = "ipfs-${var.base_namespace}-internal.${var.domain}"

  api_lb_external = var.enable_external_api ? [
    {
      target_group_arn = aws_lb_target_group.api[0].arn
      container_name   = "ipfs"
      container_port   = local.api_port
    }
  ] : []

  api_lb_internal = var.enable_internal_api ? [
    {
      target_group_arn = module.alb_internal[0].target_group_arns[0]
      container_name   = "ipfs"
      container_port   = local.api_port
    }
  ] : []

  gateway_lb_external = var.enable_external_gateway ? [
    {
      target_group_arn = aws_lb_target_group.gateway[0].arn
      container_name   = "ipfs"
      container_port   = local.gateway_port
    }
  ] : []

  gateway_lb_internal = var.enable_internal_gateway ? [
    {
      target_group_arn = module.alb_internal[0].target_group_arns[1]
      container_name   = "ipfs"
      container_port   = local.gateway_port
    }
  ] : []

  swarm_lb_external = [
    {
      target_group_arn = aws_lb_target_group.swarm_tcp.arn
      container_name   = "ipfs"
      container_port   = local.swarm_tcp_port
    },
    {
      target_group_arn = aws_lb_target_group.swarm_ws.arn
      container_name   = "ipfs"
      container_port   = local.swarm_ws_port
    }
  ]

  dynamic_load_balancers = concat(
    local.api_lb_external,
    local.api_lb_internal,
    local.gateway_lb_external,
    local.gateway_lb_internal,
    local.swarm_lb_external
  )

  log_level = "info"

  s3_lifecycle_rules = [
    {
      enabled = true

      noncurrent_version_expiration = {
        days = 30
      }
    }
  ]
}
