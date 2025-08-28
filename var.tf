variable "project_name" {
  description = "Project name identifier"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

################
##### VPC ######
################
variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subpub1" {
  description = "CIDR block for public subnet 1"
  type        = string
}

variable "subpub2" {
  description = "CIDR block for public subnet 2"
  type        = string
}

variable "subpvt1" {
  description = "CIDR block for private subnet 1"
  type        = string
}

variable "subpvt2" {
  description = "CIDR block for private subnet 2"
  type        = string
}

variable "az_sub_pub1" {
  description = "Availability zone for public subnet 1"
  type        = string
}

variable "az_sub_pub2" {
  description = "Availability zone for public subnet 2"
  type        = string
}

variable "az_sub_pvt1" {
  description = "Availability zone for private subnet 1"
  type        = string
}

variable "az_sub_pvt2" {
  description = "Availability zone for private subnet 2"
  type        = string
}

##########################
# ECS Cluster & Instance #
##########################
variable "ecs_ami_id" {
  description = "AMI ID for ECS instances"
  type        = string
}

variable "ecs_instance_type" {
  description = "EC2 instance type for ECS"
  type        = string
}

variable "ecr_repo_name" {
  description = "ECR repository name"
  type        = string
}

####################
# Task Definition  #
####################
variable "task_cpu" {
  description = "CPU units for ECS task"
  type        = number
}

variable "task_memory" {
  description = "Memory (MB) for ECS task"
  type        = number
}

variable "container_name" {
  description = "Container name"
  type        = string
}

variable "container_image_tag" {
  description = "Tag for the container image"
  type        = string
}

variable "container_cpu" {
  description = "CPU units for container"
  type        = number
}

variable "container_memory" {
  description = "Memory (MB) for container"
  type        = number
}

variable "container_port" {
  description = "Container port"
  type        = number
}

variable "host_port" {
  description = "Host port"
  type        = number
}

#####################
# ECS Service Config#
#####################
variable "service_desired_count" {
  description = "Number of ECS service tasks to run"
  type        = number
}


################
##### RDS ######
################

variable "db_engine" {
  description = "RDS database engine"
  type        = string
}

variable "db_engine_version" {
  description = "RDS engine version"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "db_port" {
  description = "Database port"
  type        = number
  default     = 3306
}

variable "db_username" {
  description = "Database admin username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database admin password"
  type        = string
  sensitive   = true
}
