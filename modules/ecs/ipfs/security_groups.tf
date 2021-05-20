resource "aws_security_group" "alb_external" {
  name        = "${local.namespace}-alb_external"
  description = "IPFS public security group to allow controlled inbound/outbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = local.healthcheck_port
    to_port     = local.healthcheck_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = local.api_port
    to_port     = local.api_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = local.gateway_port
    to_port     = local.gateway_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = local.swarm_ws_port
    to_port     = local.swarm_ws_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.default_tags
}

resource "aws_security_group" "alb_internal" {
  name        = "${local.namespace}-alb_internal"
  description = "IPFS public security group to allow controlled inbound/outbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = local.healthcheck_port
    to_port     = local.healthcheck_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = local.api_port
    to_port     = local.api_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = local.gateway_port
    to_port     = local.gateway_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = local.swarm_ws_port
    to_port     = local.swarm_ws_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.default_tags
}

module "api_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.0"

  name        = "${local.namespace}-api"
  description = "VPC access to IPFS API ports"
  vpc_id      = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = local.api_port
      to_port     = local.api_port
      protocol    = "tcp"
      description = "IPFS API port"
      cidr_blocks = "${var.vpc_cidr_block},127.0.0.1/32"
    }
  ]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  tags = local.default_tags
}
