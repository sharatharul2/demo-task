resource "aws_db_instance" "mariadb" {
  identifier              = "${local.name}-mariadb"
  engine                  = var.db_engine
  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_class
  allocated_storage       = 20
  max_allocated_storage   = 100
  storage_type            = "gp2"
  db_name                 = "appdb"
  username                = var.db_username
  password                = var.db_password
 port                    = var.db_port
  multi_az                = false
  publicly_accessible     = false 
  vpc_security_group_ids  = [aws_security_group.pvt_seg.id]
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  skip_final_snapshot     = true

  tags = merge(local.common_tags, {
    Name = "${local.name}-rds"
  })
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${local.name}-rds-subnet-group"
  subnet_ids = [aws_subnet.pvtsub1.id,aws_subnet.pvtsub2.id]

  tags = merge(local.common_tags, {
    Name = "${local.name}-rds-subnet-group"
  })
}