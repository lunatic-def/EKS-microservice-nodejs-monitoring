# Local tfstate for testing purpose
data "terraform_remote_state" "eks"{
  backend = "local"
  config = {
    #path = "../../infrastructure/terraform.tfstate"
    path = "../infrastructure/terraform.tfstate"
  }
}
