module "s3_ceramic_state_store_task_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "2.23"

  name = "s3CeramicStateStoreTask-${local.namespace}"

  custom_group_policy_arns = [
    aws_iam_policy.s3_ceramic_node_state_store.arn
  ]
  group_users = [module.s3_ceramic_state_store_task_user.this_iam_user_name]
}

module "s3_ceramic_state_store_task_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "3.0"

  name = "${local.namespace}-s3CeramicStateStoreTask"

  create_iam_access_key         = true
  create_iam_user_login_profile = false
  force_destroy                 = false

  tags = local.default_tags
}

resource "aws_iam_policy" "s3_ceramic_node_state_store" {
  name        = "CeramicStateStoreS3-${local.namespace}-node"
  path        = "/"
  description = "Allows read and write access for Ceramic State Store S3 storage"

  policy = templatefile("${path.module}/templates/state_store_s3_policy.json.tpl", {
    resource  = var.s3_bucket_arn
    directory = var.directory_namespace
  })
}

resource "aws_iam_policy" "ecs_exec_policy" {
  name = "ECSExecPermissions-${local.namespace}"

  policy = file("${path.module}/templates/ecs_exec_policy.json")
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
    "arn:aws:iam::aws:policy/AmazonElasticFileSystemClientFullAccess",
    aws_iam_policy.ecs_exec_policy.arn
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
