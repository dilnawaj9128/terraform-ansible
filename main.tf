#Keypair login
resource "aws_key_pair" "my_new_key" {

  key_name   = "ansible-key"

  public_key = file("ansible-key.pub")
}
#VPC
resource "aws_default_vpc" "default" {
  
}

# security-group.tf

resource "aws_security_group" "ec2_sg" {

  name        = "terraform-sg"
  description = "Allow SSH and HTTP"

  # SSH Port
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP Port
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ec2.tf

resource "aws_instance" "servers" {

  for_each = tomap({
    master-node     = "ami-05d62b9bc5a6ca605"

    my-server1      = "ami-05d62b9bc5a6ca605"

    my-server2      = "ami-0754facaaac92a5bb"

    my-server3 = "ami-0b2ab3a97a77bd35e"

  })

  ami           = each.value

  instance_type = "t3.micro"
  key_name = aws_key_pair.my_new_key.key_name

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]
  

  # 10 GB Volume
  root_block_device {

    volume_size = 10

    volume_type = "gp3"
  }

  tags = {

    Name = each.key
  }
}
