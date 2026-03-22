# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy

resource "aws_autoscaling_policy" "web_tier_cpu" {
  name                      = "web-tier-cpu-policy"
  autoscaling_group_name    = aws_autoscaling_group.web_tier_asg.name
  estimated_instance_warmup = 60
  policy_type               = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 40.0
  }
}