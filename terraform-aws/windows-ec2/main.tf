provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "windowsEC2" {
  ami                    = "ami-02676461ac0a6ae2e"
  instance_type          = "t2.micro"
  key_name               = "terra-key-pair"
  vpc_security_group_ids = [aws_security_group.winddwsSG.id]

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }

  tags = {
    Name = "windowsInstance"
  }
}

resource "aws_security_group" "winddwsSG" {
  name        = "windowsSG"
  description = "Allow rdp and http port"

  ingress {
    from_port   = 3389
    to_port     = 3389
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
  value       = [aws_instance.windowsEC2.public_ip]
}

output "instance_private_ip" {
  description = "ec2 private ip"
  value       = [aws_instance.windowsEC2.private_ip]
}