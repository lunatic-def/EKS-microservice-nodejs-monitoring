output "db_instance_address" {
  value = module.mysql-db.db_instance_address
}

output "db_instance_endpoint" {
  value = module.mysql-db.db_instance_endpoint
}

output "db_instance_identifier"{
    value = module.mysql-db.db_instance_identifier
}

output "rds-all" {
    value = module.mysql-db  
}