resource "aws_key_pair" "vikingcloud" {
  key_name   = "vikingcloud-key"
  public_key = file("${path.module}/key_pair/vikingcloud-key.pub")
}

resource "aws_instance" "vikingcloud_ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.vc_public[0].id
  key_name                    = aws_key_pair.vikingcloud.key_name
  associate_public_ip_address = true

  tags = {
    Name = "vikingcloud-ec2"
  }
}


