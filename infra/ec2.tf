resource "aws_key_pair" "my_key_pair" {
  key_name   = "${var.env}-infra-app-key"
  public_key = file("vscode.pub")
 tags= {
    Environment = var.env
    name = var.env
  }  
}
resource "aws_default_vpc" "default" {
  }

resource "aws_security_group" "my_security_group" {
  name        = "${var.env}-infra-app-sg"
  description = "Security group for the ${var.env} environment"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
tags = {
    Name = "${var.env}-infra-app-sg"
    environment = var.env
}
}

resource "aws_instance" "my_instance" {
 count = var.instance_count
  ami = var.ec2_ami
  instance_type = var.instance_type
  depends_on = [aws_security_group.my_security_group]
  security_groups = [aws_security_group.my_security_group.name]
  key_name = aws_key_pair.my_key_pair.key_name
 root_block_device {
    volume_size = var.env == "prod" ? 20 : 28

 }
 tags = {
    Name = "${var.env}-infra-app-instance-${count.index + 1}"
    Environment = var.env
 }

}