resource "aws_instance" "kubectl-server" {
  ami = var.ami_id
  key_name = var.key_pair
  instance_type = var.instance_type
  associate_public_ip_address = true
  subnet_id = var.pub_subnet_id
  vpc_security_group_ids = [aws_security_group.kubectl_sg.id]

  tags = {
    Name = "kubectl"
  }  
}