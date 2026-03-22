# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_attachment

# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "web-tier-attachment" {
  autoscaling_group_name = aws_autoscaling_group.web_tier_asg.name
  lb_target_group_arn    = aws_lb_target_group.web_tier_tg.arn
}