resource "aws_ecs_cluster" "my_cluster" {
  name = "${local.name}-cluster"

  tags = merge(local.common_tags, { Name = "${local.name}-ecs-cluster" })
}

resource "aws_instance" "ecs_instance" {
  ami                         = var.ecs_ami_id
  instance_type               = var.ecs_instance_type
  subnet_id                   = aws_subnet.pubsub1.id
  vpc_security_group_ids      = [aws_security_group.pub_seg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              echo "ECS_CLUSTER=${aws_ecs_cluster.my_cluster.name}" >> /etc/ecs/ecs.config
              EOF

  tags = merge(local.common_tags, { Name = "${local.name}-ecs-instance" })
}

resource "aws_ecr_repository" "my_app" {
  name = var.ecr_repo_name

  tags = merge(local.common_tags, { Name = "${local.name}-ecr" })
}

resource "aws_ecs_task_definition" "my_task" {
  family                   = "${local.name}-task"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = <<DEFINITION
  [
    {
      "name": "${var.container_name}",
      "image": "${aws_ecr_repository.my_app.repository_url}:${var.container_image_tag}",
      "memory": ${var.container_memory},
      "cpu": ${var.container_cpu},
      "essential": true,
      "portMappings": [
        {
          "containerPort": ${var.container_port},
          "hostPort": ${var.host_port}
        }
      ],
      "environment": [
        { "name": "DB_HOST", "value": "${aws_rds_instance.db.address}" },
        { "name": "S3_BUCKET", "value": "${aws_s3_bucket.app_bucket.bucket}" }
      ]
    }
  ]
  DEFINITION

  tags = merge(local.common_tags, { Name = "${local.name}-task-def" })
}

resource "aws_ecs_service" "my_service" {
  name            = "${local.name}-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task.arn
  desired_count   = var.service_desired_count
  launch_type     = "EC2"

  tags = merge(local.common_tags, { Name = "${local.name}-ecs-service" })
}