module "ecs_ipfs_task_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "3.0"

  name = "ecsIpfsTask-${local.namespace}"

  create_iam_access_key         = true
  create_iam_user_login_profile = false
  force_destroy                 = false

  tags = local.default_tags
}

module "ecs_ipfs_task_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "2.22.0"

  trusted_role_services = [
    "ecs-tasks.amazonaws.com"
  ]

  create_role = true

  role_name         = "ecsIPFSTaskRole-${local.namespace}"
  role_requires_mfa = false

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonElasticFileSystemClientFullAccess",
    aws_iam_policy.main.arn
  ]

  tags = local.default_tags
}

resource "aws_iam_policy" "main" {
  name        = "IPFSS3-${local.namespace}"
  path        = "/"
  description = "Allows get, list, and put access for IPFS S3 repo storage"

  policy = data.template_file.s3_policy.rendered
}

data "template_file" "s3_policy" {
  template = file("${path.module}/templates/s3_policy.json.tpl")

  vars = {
    resource = module.s3_ipfs.this_s3_bucket_arn
  }
}

module "ecs_task_execution_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "2.22.0"

  trusted_role_services = [
    "ecs-tasks.amazonaws.com"
  ]

  create_role = true

  role_name         = "ecsTaskExecutionRole-${local.namespace}"
  role_requires_mfa = false

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
  ]

  tags = local.default_tags
}
