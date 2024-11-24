# Security Group for AWS RDS DB
module "rdsdb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "rdsdb-sg"
  description = "Access to MySQL DB for entire VPC CIDR Block"
  vpc_id      = var.vpc.vpc_id

  # ingress should chance to eks secruity group id this is just for testing !!
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = var.vpc.cidr_blocks
    },
  ]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags         = { name = "rds_secgroup" }
}



module "mysql-db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.3.0"
  #kms_key_id = 

  identifier = var.db_instance_identifier #masterdb

  db_name                     = var.db_name #mywebdb
  username                    = var.db_username
  password                    = var.db_password
  manage_master_user_password = false # not using secret manager

  multi_az               = false # not using standby instance
  create_db_subnet_group = true
  subnet_ids             = var.vpc.database_subnets
  vpc_security_group_ids = [module.rdsdb_sg.security_group_id]
  port                   = 3306

  engine               = "mysql"
  engine_version       = "8.0.35"
  family               = "mysql8.0" # DB parameter group
  major_engine_version = "8.0"      # DB option group
  instance_class       = "db.t4g.micro"

  allocated_storage     = 10
  max_allocated_storage = 20



  # maintenance_window              = "Mon:00:00-Mon:03:00"
  # backup_window                   = "03:00-06:00"
  # enabled_cloudwatch_logs_exports = ["general"]

  backup_retention_period = 7
  skip_final_snapshot     = true
  deletion_protection     = false
  storage_encrypted       = false
  #kms_key_id = module.kms.key_arn

  # performance_insights_enabled          = true
  # performance_insights_retention_period = 7
  # create_monitoring_role                = true
  # monitoring_interval                   = 60

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8"
    },
    {
      name  = "character_set_server"
      value = "utf8"
    }
  ]

  tags = { name = "master_mysql" }
  db_instance_tags = {
    "Sensitive" = "high"
  }
  db_option_group_tags = {
    "Sensitive" = "low"
  }
  db_parameter_group_tags = {
    "Sensitive" = "low"
  }
  db_subnet_group_tags = {
    "Sensitive" = "high"
  }
}

resource "null_resource" "create_user_details_table" {
  provisioner "local-exec" {
    command = <<EOT
      mysql -u ${var.db_username} -p ${var.db_password} -h ${module.mysql-db.db_instance_address} -e "CREATE TABLE newdb.USER_DETAILS (username varchar(255), password varchar(255), gender varchar(255), PRIMARY KEY (username));"
    EOT
  }

  depends_on = [module.mysql-db]
}