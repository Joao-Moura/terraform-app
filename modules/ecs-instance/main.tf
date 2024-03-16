resource "aws_ecs_service" "ecs_service" {
  name = var.service_name
  cluster = aws_ecs_cluster.ecs_cluster.arn
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count = var.ecs_service_count

  // tags = var.tags
  depends_on = [aws_iam_role.ecs_task_role]
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family = var.family_name
  network_mode = "bridge"
  task_role_arn = aws_iam_role.ecs_task_role.arm
  execution_role_arn = aws_iam_role.ecs_task_role.arm
  container_definitions = var.container_definition
}
