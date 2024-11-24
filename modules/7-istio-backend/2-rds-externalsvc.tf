
# resource "kubernetes_service_v1" "mysql_service" {
#   metadata {
#     name = "mysql-service"
#     labels = {
#       app = "mysql-service"
#     }
#   }

#   spec {
#     type          = "ExternalName"
#     #external_name = "mysqldb.cdk2kwaw6ex8.us-east-1.rds.amazonaws.com""
#     external_name = "${data.terraform_remote_state.eks.outputs.rds.db_instance_address}"
#   }
# }
