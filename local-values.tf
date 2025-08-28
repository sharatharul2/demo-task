locals {
  name = "${var.environment}-${var.project_name}"
  common_tags = {
    owners = var.project_name
    environment= var.environment
  }
}