# Project Metadata #
project_name = "demo-healthcare-app"
environment  = "dev"

# VPC
cidr_vpc     = "10.0.0.0/16"
subpub1      = "10.0.1.0/24"
subpub2      = "10.0.2.0/24"
subpvt1      = "10.0.3.0/24"
subpvt2      = "10.0.4.0/24"

az_sub_pub1  = "us-east-1a"
az_sub_pub2  = "us-east-1b"
az_sub_pvt1  = "us-east-1a"
az_sub_pvt2  = "us-east-1b"

# ECS EC2 Config
ecs_ami_id        = "ami-0de53d8956e8dcf80"
ecs_instance_type = "t2.medium"

# ECR Config
ecr_repo_name = "my-app-repo"

# ECS Task Config
task_cpu    = 256
task_memory = 512

# Container Config
container_name       = "my-container"
container_image_tag  = "latest"
container_cpu        = 256
container_memory     = 512
container_port       = 80
host_port            = 80

# ECS Service Config
service_desired_count = 1

# RDS  
db_engine         = "mariadb"
db_engine_version = "10.11.6"    # LTS MariaDB (supported by AWS RDS)
db_instance_class = "db.t3.micro"
db_username       = "admin"
db_password       = "DevMariaDBPass123!"
db_port           = 3306