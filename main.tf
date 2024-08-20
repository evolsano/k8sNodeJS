terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.63.0"
    }
  }
}

provider "aws" {
    region = "ap-southeast-1"
  
}

resource "aws_security_group" "cog_k8s_sg" {
  #vpc_id = aws_vpc.cog_vpc.id
  name = "COG k8s SG"

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_key_pair" "wkl-cognixus-key" {
  key_name   = "wkl-cognixus2"
  public_key = file("~/.ssh/cognixus.pub") # Path to your public key file
}

resource "aws_instance" "k8s_ec2" {
  ami           = "ami-060e277c0d4cce553" #Ubuntu Server 24.04 LTS
  instance_type = "t2.medium"
  #subnet_id     = aws_subnet.cog_pub_subnet_1a.id
  key_name      = aws_key_pair.wkl-cognixus-key.key_name
  security_groups = [aws_security_group.cog_k8s_sg.name]
  #vpc_security_group_ids = [aws_security_group.cog_sg.id]

  #user_data = file("install_docker.sh")
  root_block_device {
    volume_size = 15
    volume_type = "gp3"
  }

  tags = {
    Name = "k8s-Server"
  }
}

# Output the public IP of the instance
output "instance_public_ip" {
  value = aws_instance.k8s_ec2.public_ip
}