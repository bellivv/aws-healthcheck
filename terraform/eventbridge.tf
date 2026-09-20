data "aws_iam_policy_document" "eventbridge_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eventbridge_ecs" {
  name               = "${var.project_name}-eventbridge-ecs"
  assume_role_policy = data.aws_iam_policy_document.eventbridge_assume_role.json

  tags = {
    Project = var.project_name
  }
}

data "aws_iam_policy_document" "eventbridge_run_task" {
  statement {
    effect    = "Allow"
    actions   = ["ecs:RunTask"]
    resources = ["${module.ecs.checker_task_definition_family_arn}:*"]
  }

  statement {
    effect  = "Allow"
    actions = ["iam:PassRole"]
    resources = [
      aws_iam_role.ecs_task_execution.arn,
      aws_iam_role.ecs_task.arn,
    ]
  }
}

resource "aws_iam_policy" "eventbridge_run_task" {
  name   = "${var.project_name}-eventbridge-run-task"
  policy = data.aws_iam_policy_document.eventbridge_run_task.json
}

resource "aws_iam_role_policy_attachment" "eventbridge_run_task" {
  role       = aws_iam_role.eventbridge_ecs.name
  policy_arn = aws_iam_policy.eventbridge_run_task.arn
}

resource "aws_cloudwatch_event_rule" "checker_schedule" {
  name                = "${var.project_name}-checker-schedule"
  schedule_expression = "rate(5 minutes)"

  tags = {
    Project = var.project_name
  }
}

resource "aws_cloudwatch_event_target" "checker" {
  rule     = aws_cloudwatch_event_rule.checker_schedule.name
  arn      = module.ecs.cluster_arn
  role_arn = aws_iam_role.eventbridge_ecs.arn

  ecs_target {
    task_definition_arn = module.ecs.checker_task_definition_family_arn
    task_count          = 1
    launch_type         = "FARGATE"

    network_configuration {
      subnets          = module.networking.public_subnet_ids
      security_groups  = [module.networking.ecs_security_group_id]
      assign_public_ip = true
    }
  }
}