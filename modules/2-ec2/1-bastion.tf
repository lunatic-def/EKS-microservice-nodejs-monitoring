module "bastion-secgroup" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

#SSH -> 0.0.0.0/0
  name        = "bastion-sg"
  description = "Security group which is used as an argument in complete-sg"
  vpc_id = var.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]
  egress_rules = ["all-all"]

  tags = {
    name = "Bastion Security Group"
  }
}

module "bastion-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.0"
  depends_on = [ var.vpc]
  name = "bastion-instance"
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  key_name = var.instance_keypair
  #user_data = file("${path.module}/jumpbox_install.sh") # use for checking the db connection 
  vpc_security_group_ids = [ module.bastion-secgroup.security_group_id]
  subnet_id =  var.vpc.public_subnets[0]
  tags = { name="bastion-instance"}
}