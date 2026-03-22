# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group

resource "aws_autoscaling_group" "web_tier_asg" {
  name                = "web-tier-asg"
  vpc_zone_identifier = [aws_subnet.private_1.id, aws_subnet.private_2.id, aws_subnet.private_3.id]
  max_size            = 6
  min_size            = 3
  health_check_type   = "ELB"
  target_group_arns   = [aws_lb_target_group.web_tier_tg.arn]

  launch_template {
    id      = aws_launch_template.web_tier_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "web-tier-instance"
    propagate_at_launch = true
  }

  force_delete = true

}