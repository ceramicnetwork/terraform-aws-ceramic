resource "aws_security_group" "efs" {
  name        = "${local.namespace}-efs"
  description = "Controls access to EFS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 2049
    to_port     = 2049
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

module "ceramic_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.0"

  name        = "${local.namespace}-ceramic"
  description = "VPC access to Ceramic ports"
  vpc_id      = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = var.ceramic_port
      to_port     = var.ceramic_port
      protocol    = "tcp"
      description = "Ceramic port"
      cidr_blocks = "${var.vpc_cidr_block},127.0.0.1/32"
    }
  ]
  ingress_with_source_security_group_id = [
    {
      from_port                = var.ceramic_port
      to_port                  = var.ceramic_port
      protocol                 = "tcp"
      description              = "Ceramic port"
      source_security_group_id = module.load_balancer_security_group.this_security_group_id
    }
  ]
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  tags = local.default_tags
}

module "load_balancer_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.0"

  name        = "${local.namespace}-load_balancer"
  description = "All access to http/s"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  tags = local.default_tags
}
