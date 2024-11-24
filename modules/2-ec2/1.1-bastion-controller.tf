resource "null_resource" "name" {
  depends_on = [module.bastion-instance]
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type     = "ssh"
    host     = aws_eip.ec2-bastion-EIP.public_ip    
    user     = "ec2-user"
    password = ""
    private_key = file("../modules/2-ec2/Webkey.pem")
  }  

## File Provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
  provisioner "file" {
    source      = "../modules/2-ec2/Webkey.pem"
    destination = "/tmp/Webkey.pem"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/Webkey.pem"
    ]
  }

}

resource "aws_eip" "ec2-bastion-EIP" {
  depends_on = [ module.bastion-instance, var.vpc]
  tags = {name="ec2-bastion-EIP"}

  instance = module.bastion-instance.id
  domain = "vpc"
}