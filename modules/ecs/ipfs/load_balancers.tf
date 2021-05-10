# Only alphanumeric characters and hyphens allowed in names and prefixes
resource "aws_lb" "external" {
  name = "${local.namespace}-alb-ex"

  load_balancer_type = "application"

  subnets         = var.public_subnet_ids
  security_groups = [aws_security_group.alb_external.id]
  idle_timeout    = 3600
  internal        = false

  access_logs {
    bucket  = module.s3_alb.this_s3_bucket_id
    prefix  = "external"
    enabled = true
  }

  tags = local.default_tags
}

/* API */

resource "aws_lb_listener" "api_http" {
  count = (var.enable_external_api && ! var.use_ssl) ? 1 : 0

  load_balancer_arn = aws_lb.external.arn
  port              = local.api_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api[0].arn
  }
}

resource "aws_lb_listener" "api_https" {
  count = (var.enable_external_api && var.use_ssl) ? 1 : 0

  load_balancer_arn = aws_lb.external.arn
  port              = local.api_port
  protocol          = "HTTPS"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api[0].arn
  }
}

resource "aws_lb_target_group" "api" {
  count = var.enable_external_api ? 1 : 0

  vpc_id      = var.vpc_id
  name_prefix = "api-"
  port        = local.api_port
  protocol    = "HTTP"
  target_type = "ip"
  health_check {
    interval            = 60
    timeout             = 30
    path                = "/"
    port                = local.healthcheck_port
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

  tags = local.default_tags

  depends_on = [aws_lb.external]
}

/* Gateway */

resource "aws_lb_listener" "gateway" {
  count = (var.enable_external_gateway && ! var.use_ssl) ? 1 : 0

  load_balancer_arn = aws_lb.external.arn
  port              = local.gateway_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.gateway[0].arn
  }
}

resource "aws_lb_listener" "gateway_https" {
  count = (var.enable_external_gateway && var.use_ssl) ? 1 : 0

  load_balancer_arn = aws_lb.external.arn
  port              = local.gateway_port
  protocol          = "HTTPS"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.gateway[0].arn
  }
}

resource "aws_lb_target_group" "gateway" {
  count = var.enable_external_gateway ? 1 : 0

  vpc_id      = var.vpc_id
  name_prefix = "gw-"
  protocol    = "HTTP"
  port        = local.gateway_port
  target_type = "ip"
  health_check {
    interval            = 60
    timeout             = 30
    path                = "/"
    port                = local.healthcheck_port
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

  tags = local.default_tags

  depends_on = [aws_lb.external]
}

/* Swarm Websocket */

resource "aws_lb_listener" "swarm_ws_http" {
  count = ! var.use_ssl ? 1 : 0

  load_balancer_arn = aws_lb.external.arn
  port              = local.swarm_ws_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.swarm_ws.arn
  }
}

resource "aws_lb_listener" "swarm_ws_https" {
  count = var.use_ssl ? 1 : 0

  load_balancer_arn = aws_lb.external.arn
  port              = local.swarm_ws_port
  protocol          = "HTTPS"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.swarm_ws.arn
  }
}

resource "aws_lb_target_group" "swarm_ws" {
  vpc_id      = var.vpc_id
  name_prefix = "swws-"
  protocol    = "HTTP"
  port        = local.swarm_ws_port
  target_type = "ip"
  health_check {
    interval            = 60
    timeout             = 30
    path                = "/"
    port                = local.healthcheck_port
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

  tags = local.default_tags

  depends_on = [aws_lb.external]
}

module "alb_internal" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  count = 1

  name = "${local.namespace}-alb-in"

  load_balancer_type = "application"
  internal           = true

  vpc_id          = var.vpc_id
  subnets         = var.private_subnet_ids
  security_groups = [aws_security_group.alb_internal.id]
  idle_timeout    = 3600

  target_groups = [
    {
      name_prefix      = "api-"
      backend_protocol = "HTTP"
      backend_port     = local.api_port
      target_type      = "ip"
      health_check = {
        interval            = 30
        path                = "/"
        port                = local.healthcheck_port
        matcher             = "200"
        healthy_threshold   = 2
        unhealthy_threshold = 3
      }
    },
    {
      name_prefix      = "gw-"
      backend_protocol = "HTTP"
      backend_port     = local.gateway_port
      target_type      = "ip"
      health_check = {
        interval            = 30
        path                = "/"
        port                = local.healthcheck_port
        matcher             = "200"
        healthy_threshold   = 2
        unhealthy_threshold = 3
      }
    },
    {
      name_prefix      = "swws-"
      backend_protocol = "HTTP"
      backend_port     = local.swarm_ws_port
      target_type      = "ip"
      health_check = {
        interval            = 30
        path                = "/"
        port                = local.healthcheck_port
        matcher             = "200"
        healthy_threshold   = 2
        unhealthy_threshold = 3
      }
    }
  ]

  http_tcp_listeners = ! var.use_ssl ? [
    {
      port               = local.api_port
      protocol           = "HTTP"
      target_group_index = 0
      action_type        = "forward"
    },
    {
      port               = local.gateway_port
      protocol           = "HTTP"
      target_group_index = 1
      action_type        = "forward"
    },
    {
      port               = local.swarm_ws_port
      protocol           = "HTTP"
      target_group_index = 2
      action_type        = "forward"
    }
  ] : []

  https_listeners = var.use_ssl ? [
    {
      port               = local.api_port
      protocol           = "HTTPS"
      certificate_arn    = var.acm_certificate_arn
      target_group_index = 0
    },
    {
      port               = local.gateway_port
      protocol           = "HTTPS"
      certificate_arn    = var.acm_certificate_arn
      target_group_index = 1
    },
    {
      port               = local.swarm_ws_port
      protocol           = "HTTPS"
      certificate_arn    = var.acm_certificate_arn
      target_group_index = 2
    }
  ] : []

  tags = local.default_tags
}
