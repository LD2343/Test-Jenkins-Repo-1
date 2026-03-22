# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group

resource "aws_lb_target_group" "web_tier_tg" {
  name     = "web-tier-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    enabled           = "true"
    healthy_threshold = 2 #overrides default value of 3 and changes to 2
  }

  tags = {
    Name = "web-tier-tg"
  }
}