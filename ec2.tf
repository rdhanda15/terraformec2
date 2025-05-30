provider "aws" {
  region = "us-east-1"  # Change to your preferred region
}

resource "aws_instance" "simple_ec2" {
  ami           = "ami-0c55b159cbfafe1f0"   # Amazon Linux 2 AMI in us-east-1 (update for your region)
  instance_type = "t2.micro"
  key_name      = "my-key-pair"             # Your SSH key pair registered in AWS

  tags = {
    Name = "SimpleEC2"
  }

  # Security group to allow SSH from anywhere (for testing only!)
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open SSH to all IPs (use your IP in production)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
