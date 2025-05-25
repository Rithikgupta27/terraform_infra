resource "aws_instance" "nginx-ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private-subnet-1.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = var.key # Optional if you want SSH access

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install nginx1 -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "nginx-ec2"
  }
}
