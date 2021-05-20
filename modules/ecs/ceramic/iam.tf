module "s3_ceramic_state_store_task_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "3.0"

  name = "${local.namespace}-s3CeramicStateStoreTask"

  create_iam_access_key         = true
  create_iam_user_login_profile = false
  force_destroy                 = false

  tags = local.default_tags
}

module "ecs_efs_task_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "2.22.0"

  trusted_role_services = [
    "ecs-tasks.amazonaws.com"
  ]

  create_role = true

  role_name         = "${local.namespace}-ecsEFSTaskRole"
  role_requires_mfa = false

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonElasticFileSystemClientFullAccess"
  ]

  tags = local.default_tags
}

module "ecs_task_execution_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "2.22.0"

  trusted_role_services = [
    "ecs-tasks.amazonaws.com"
  ]

  create_role = true

  role_name         = "${local.namespace}-ecsTaskExecutionRole"
  role_requires_mfa = false

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
  ]

  tags = local.default_tags
}
