module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "5.0.3"
   create_db_subnet_group =  true
   db_subnet_group_name =  data.terraform_remote_state.vpc.outputs.database_subnet_group_name
   create_db_parameter_group  = false
   create_db_option_group =  false
   storage_encrypted = false
   create_random_password =  false
  
  
  
  db_name  = var.db-name
  identifier = var.db-name
  username =  var.db_username
  password =  var.db_password
  port = 3306
 


  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine               = "mysql"
  engine_version       = "8.0.27"
  family               = "mysql8.0" # DB parameter group
  major_engine_version = "8.0"      # DB option group
  instance_class       = "db.t2.micro"

  allocated_storage     = 20
  max_allocated_storage = 100

 

  multi_az               = true
  subnet_ids             =  data.terraform_remote_state.vpc.outputs.database_subnets
  vpc_security_group_ids = [ data.terraform_remote_state.RDS_sg.outputs.rds_security_group_id ]

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["general"]
  create_cloudwatch_log_group     = true

  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false

  
  create_monitoring_role                = true
  monitoring_interval                   = 60

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

 tags =  {
     Name= "MY-RDS"
 }
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
