provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3a.micro"

  ebs_block_device {
    device_name = "/dev/sdd"
    volume_type = "gp2"
    volume_size = 30
    delete_on_termination = true
    encrypted = true
  }

  tags = {
    Name = "zeal tech"
  }
}