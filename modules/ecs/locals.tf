locals {
  default_tags = {
    Terraform = true
    Ceramic   = var.env
  }
  namespace = var.ceramic_namespace
  dynamic_load_balancers = var.create_ceramic_alb ? concat(
    [
      {
        target_group_arn = module.alb[0].target_group_arns[0]
        container_name   = var.run_as_gateway ? "ceramic-gateway" : "ceramic-node"
        container_port   = var.ceramic_port
      }
    ],
    var.ceramic_load_balancer_contents
  ) : var.ceramic_load_balancer_contents
}
