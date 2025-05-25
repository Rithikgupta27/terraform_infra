resource "aws_security_group" "alb-sg" {
  name = "alb-sg"
  description = "it is alb security group"
  vpc_id = aws_vpc.nginx-demo.id
  tags = {
    Name = "alb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb-ingress-https" {
   security_group_id = aws_security_group.alb-sg.id
   cidr_ipv4 = "0.0.0.0/0"
   from_port = 443
   ip_protocol = "tcp"
   to_port  = 443

}

resource "aws_vpc_security_group_ingress_rule" "alb-ingress-http" {
   security_group_id = aws_security_group.alb-sg.id
   cidr_ipv4 = "0.0.0.0/0"
   from_port = 80
   ip_protocol = "tcp"
   to_port  = 80

}



resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}