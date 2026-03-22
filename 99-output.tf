# Outputs display important information after terraform apply

output "lb_url" {
  value = "http://${aws_lb.web_tier_lb.dns_name}"
}