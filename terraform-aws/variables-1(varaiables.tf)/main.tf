provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "ec2" {
  ami                    = "ami-05fa46471b02db0ce"
  instance_type          = "t2.micro"
  key_name               = "terra-key-pair"
  vpc_security_group_ids = [aws_security_group.sg.id]

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }

  tags = {
    Name = "variable-1"
  }
}

resource "aws_security_group" "sg" {

  name        = "linux-sg"
  description = "Allow ssh port access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr]
  }

}

output "instance_public_ip" {
  description = "instance public ip"
  value       = [aws_instance.ec2.public_ip]
}