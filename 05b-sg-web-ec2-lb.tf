# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule

# Web ALB Security Group 
resource "aws_security_group" "web_ec2_sg" {
  name        = "web-ec2-lb"
  description = "Allow traffic from Web ALB"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "web-ec2-sg"
    Tier = "web"
  }
}

resource "aws_vpc_security_group_ingress_rule" "web_ec2_http" {
  security_group_id            = aws_security_group.web_ec2_sg.id
  description                  = "HTTP from Web LB"
  referenced_security_group_id = aws_security_group.web_alb_sg.id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}

resource "aws_vpc_security_group_ingress_rule" "web_ec2_ssh" {
  security_group_id = aws_security_group.web_ec2_sg.id
  description       = "SSH from Web LB"
  cidr_ipv4         = "10.130.0.0/16"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "web_ec2_egress" {
  security_group_id = aws_security_group.web_ec2_sg.id
  description       = "Allow all outbound traffic"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}