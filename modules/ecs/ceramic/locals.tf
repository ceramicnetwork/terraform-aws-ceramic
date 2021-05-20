locals {
  default_tags   = var.base_tags
  namespace      = var.namespace
  container_name = "ceramic_node"
  dynamic_load_balancers = concat(
    [
      {
        target_group_arn = module.alb.target_group_arns[0]
        container_name   = local.container_name
        container_port   = var.ceramic_port
      }
    ],
    var.ceramic_load_balancer_contents
  )
}
