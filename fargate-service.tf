resource "aws_ecs_service" "fargate" {
  count                              = var.create_service ? 1 : 0
  name                               = var.family
  cluster                            = "arn:aws:ecs:${local.region}:${local.account_id}:cluster/${var.cluster_name}"
  task_definition                    = aws_ecs_task_definition.ecs_task_definition[count.index].arn
  desired_count                      = var.desired_capacity
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  platform_version                   = var.platform_version
  launch_type                        = "FARGATE"
  health_check_grace_period_seconds  = 10
  force_new_deployment               = true

  lifecycle {
    ignore_changes = [desired_count]
  }

  load_balancer {
    target_group_arn = var.alb_arn
    container_name   = var.family
    container_port   = var.container_port
  }

  network_configuration {
    subnets          = var.private_subnet_ids != null ? var.private_subnet_ids : data.aws_subnet_ids.default[0].ids
    security_groups  = setunion([aws_security_group.fargate.id], var.security_group_ids)
    assign_public_ip = var.private_subnet_ids == null
  }
}
resource "aws_security_group" "fargate" {
  name        = "${var.family}-svc-sg"
  description = "A security group used by the ${var.family} ecs fargate service"
  vpc_id      = var.vpc_id
  ingress {
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [var.alb_sg]
    self            = true
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

