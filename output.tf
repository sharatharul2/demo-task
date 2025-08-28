# ECS Resources  
output "ecs_cluster_id" {
  description = "ECS Cluster ID"
  value       = aws_ecs_cluster.main.id
}

output "ecs_service_name" {
  description = "ECS Service Name"
  value       = aws_ecs_service.main.name
}

output "ecs_task_definition" {
  description = "ECS Task Definition Family"
  value       = aws_ecs_task_definition.app.family
}

# ECR Repository 
output "ecr_repo_url" {
  description = "ECR repository URL for pushing images"
  value       = aws_ecr_repository.app.repository_url
}

# RDS Database  
output "db_endpoint" {
  description = "RDS database endpoint"
  value       = aws_db_instance.app.endpoint
}

output "db_name" {
  description = "Database name"
  value       = aws_db_instance.app.db_name
}