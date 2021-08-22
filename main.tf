provider "aws" {
  profile = "default"
  region  = "ap-southeast-1"
}

resource "tls_private_key" "task6key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "task6key"
  public_key = tls_private_key.task6key.public_key_openssh
}

variable "ingressrules" {
  type    = list(number)
  default = [80, 443, 22]
}

resource "aws_security_group" "web_traffic" {
  name        = "Allow web traffic"
  description = "Allow ssh and standard http/https ports inbound and everything outbound"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Terraform" = "true"
  }
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

  owners = ["099720109477"]
}

resource "aws_instance" "task6" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.web_traffic.name]
  key_name        = aws_key_pair.generated_key.key_name
  
  
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install git",
      "sudo apt -y upgrade",
      "python3 -V",
	  "sudo snap install go --classic",
	  "cd /home/ubuntu",
	  "mkdir task6",
	  "cd task6",
	  "mkdir python",
	  "mkdir golang",
	  "cd python",
	  "git clone https://github.com/mdhusseini/task6_python.git",
	  "cd ../golang",
	  "git clone https://github.com/mdhusseini/task6_golang.git",
    ]
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = tls_private_key.task6key.private_key_pem
  }
  
  tags = {
    "Name"      = "task6_vm"
    "Terraform" = "true"
  }
}