# Must be scheduled via AWS
resource "aws_datasync_task" "main" {
  count                    = var.enable_repo_backup_to_s3 ? 1 : 0
  source_location_arn      = aws_datasync_location_efs.efs_repo_volume[0].arn
  destination_location_arn = aws_datasync_location_s3.s3_ipfs_repo[0].arn

  name                     = "${local.namespace}-repo"
  cloudwatch_log_group_arn = aws_cloudwatch_log_group.data_sync[0].arn # Must be enabled in AWS
  options {
    verify_mode = "NONE"
    log_level   = "BASIC"
  }

  tags = local.default_tags
}

resource "aws_datasync_location_efs" "efs_repo_volume" {
  count               = var.enable_repo_backup_to_s3 ? 1 : 0
  efs_file_system_arn = data.aws_efs_mount_target.efs_repo_volume.file_system_arn

  ec2_config {
    security_group_arns = flatten([
      module.efs_repo_volume.security_group_arn,
      data.aws_security_groups.subnet.arns
    ])
    subnet_arn = data.aws_subnet.mount_target.arn
  }

  tags = local.default_tags
}

resource "aws_datasync_location_s3" "s3_ipfs_repo" {
  count         = var.enable_repo_backup_to_s3 ? 1 : 0
  s3_bucket_arn = var.s3_repo_backup_bucket_arn
  subdirectory  = local.namespace

  s3_config {
    bucket_access_role_arn = module.s3_data_sync_role.this_iam_role_arn
  }

  tags = local.default_tags
}

data "aws_efs_mount_target" "efs_repo_volume" {
  mount_target_id = module.efs_repo_volume.mount_target_ids[0]
}

data "aws_subnet" "mount_target" {
  id = data.aws_efs_mount_target.efs_repo_volume.subnet_id
}

data "aws_security_groups" "subnet" {
  filter {
    name = "group-id"
    values = [
      var.efs_security_group_id,
      var.vpc_security_group_id
    ]
  }
}
