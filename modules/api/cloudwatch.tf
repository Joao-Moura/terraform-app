resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name = "${var.service_name}-log"
  retention_in_days = 30
  kms_key_id = null #tfsec:ignore:AWS089

  // tags = var.tags
}
