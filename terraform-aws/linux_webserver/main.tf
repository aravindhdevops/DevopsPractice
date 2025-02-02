provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "windowsEC2" {
  ami                    = "ami-05fa46471b02db0ce"
  instance_type          = "t2.micro"
  key_name               = "terra-key-pair"
  vpc_security_group_ids = [aws_security_group.winddwsSG.id]
  count                  = 1
  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }

  tags = {
    Name = element(["webserver"], count.index)
  }
  user_data = file("httpd.sh")
}

resource "aws_security_group" "winddwsSG" {
  name        = "linuxSG"
  description = "Allow ssh and http port"

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
}

output "instance_public_ip" {
  description = "ec2 public ip"
  value       = [for i in aws_instance.windowsEC2 : i.public_ip]
}

output "instance_private_ip" {
  description = "ec2 private ip"
  value       = [for i in aws_instance.windowsEC2 : i.private_ip]
}