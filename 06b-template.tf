# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template

resource "aws_launch_template" "web_tier_lt" {
  name        = "web-tier-lt"
  description = "Launch template for web tier servers"

  image_id               = "ami-07860a2d7eb515d9a"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web_ec2_sg.id]
  user_data              = filebase64("./scripts/linux-script1.sh")

  tags = {
    Name = "web-tier-lt"
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      ManagedBy = "Terraform"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}