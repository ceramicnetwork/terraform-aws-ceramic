module "base" {
  source = "../modules/base"

  aws_region = "us-east-2"
  env        = "dev"
}

module "tests" {
  source = "../modules/tests"

  aws_region                  = module.base.aws_region
  az_count                    = 1
  base_namespace              = module.base.namespace
  base_tags                   = module.base.tags
  ecs_task_execution_role_arn = module.base.ecs_task_execution_role_arn
  env                         = module.base.env
  vpc                         = module.base.vpc
}
