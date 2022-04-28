# network.tf 

# References to required network resources
data "aws_vpc" "main" {
 filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.main.id

  tags = {
    Name   = var.subnet_name
  }
}

# We need this to get the reference to the listener
data "aws_lb" "main" {
  name = "${var.application_name}-lb"
}

# Needed by the service
data "aws_lb_listener" "main" {
  load_balancer_arn = data.aws_lb.main.arn
  port              = var.tls_port
}

data "aws_lb_target_group" "main" {
    name = "${var.application_name}-tg"
}
