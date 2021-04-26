module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"

  count = var.create_ceramic_alb ? 1 : 0

  name = var.ceramic_namespace

  load_balancer_type = "application"

  vpc_id          = var.vpc_id
  subnets         = var.alb_subnet_ids
  security_groups = [module.load_balancer_security_group.this_security_group_id]
  idle_timeout    = 3600

  access_logs = {
    bucket = data.aws_s3_bucket.alb.id
  }

  target_groups = [
    {
      name_prefix      = "cera-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "ip"
      health_check = {
        interval            = 30
        path                = "/api/v0/node/healthcheck"
        port                = var.ceramic_port
        matcher             = "200"
        healthy_threshold   = 2
        unhealthy_threshold = 3
      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
      action_type        = "redirect"
      redirect = {
        port        = 443
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = var.ssl_certificate_arn
      target_group_index = 0
    }
  ]

  tags = var.default_tags
}

data "aws_lb" "main" {
  arn = var.create_ceramic_alb ? module.alb.this_load_balancer_arn : var.load_balancer_arn
}
