resource "aws_lb" "nginx-alb" {
  name = nginx-alb
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb-sg.id]
  subnets = [aws_subnet.public-subnet-1.id,aws_subnet.public-subnet-2.id]
  
  enable_deletion_protection = true
  tags = {
    Name = "nginx-alb"
    Environment = "production"
  }
}

resource "aws_lb_target_group" "alb_default_tg" {
  name     = "alb-default-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.nginx-demo.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }

  tags = {
    Name = "alb-default-tg"
  }
}


resource "aws_lb_listener" "nginx_listener" {
  load_balancer_arn = aws_lb.nginx_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-east-1:123456789012:certificate/your-certificate-id"  # 🔁 Replace with your ACM ARN

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_default_tg.arn
  }
}

