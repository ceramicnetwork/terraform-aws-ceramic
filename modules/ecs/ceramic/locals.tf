locals {
  default_tags = var.default_tags
  namespace    = var.namespace
  dynamic_load_balancers = concat(
    [
      {
        target_group_arn = module.alb.target_group_arns[0]
        container_name   = "ceramic-node"
        container_port   = var.ceramic_port
      }
    ],
    var.ceramic_load_balancer_contents
  )
}
