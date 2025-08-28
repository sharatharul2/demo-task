resource "aws_efs_file_system" "app_efs" {
  creation_token = "${local.name}-efs"

  tags = merge(local.common_tags, { Name = "${local.name}-efs" })
}