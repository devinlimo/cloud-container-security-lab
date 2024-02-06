# EC2 Instance
resource "aws_instance" "proxy" {
  ami           = var.proxy_ami
  instance_type = var.proxy_instance_type
  key_name      = var.proxy_key_name
  subnet_id     = aws_subnet.dev1-subnet.id

  tags = {
    Name = "ProxyInstance"
  }
}