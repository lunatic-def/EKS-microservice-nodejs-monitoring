module "efs-allow-access" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"


  name        = "efs-allow-nfs-from-eks-vpc"
  description = "Allow Inbound NFS Traffic from VPC CIDR"
  vpc_id = data.terraform_remote_state.eks.outputs.vpc.vpc_id

  #allow alb
  ingress_with_cidr_blocks = [
    {
      from_port   = 2049
      to_port     = 2049
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = [data.terraform_remote_state.eks.outputs.vpc.cidr_blocks]
       
    }
  ]
  egress_rules = ["all-all"]

  tags = {
    name = "allow_nfs_from_eks_vpc"
  }
}

# Resource: EFS File System
resource "aws_efs_file_system" "efs_file_system" {
  creation_token = "efs-demo"
  tags = {
    Name = "efs-demo"
  }
}

# Resource: EFS Mount Target
resource "aws_efs_mount_target" "efs_mount_target" {
  #for_each = toset(module.vpc.private_subnets)
  count = 2
  file_system_id = aws_efs_file_system.efs_file_system.id
  subnet_id      = data.terraform_remote_state.eks.outputs.vpc.private_subnets[count.index]
  security_groups = [ module.efs-allow-access.id ]
}