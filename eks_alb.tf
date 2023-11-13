resource "aws_lb" "eks_alb" {
  name               = "eks_alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.eks_alb_sg.id]
  subnets            = var.subnet_ids  

  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true
  enable_http2                     = true

  tags = {
    Name = "eks_alb"
  }
}

resource "aws_lb_listener" "eks_alb_listener" {
  load_balancer_arn = aws_lb.eks_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response  {
      content_type       = "text/plain"
      status_code        = "200"
      message_body       = "OK"
    }
  }
}

resource "aws_lb_target_group" "eks_alb_target_group" {
  name        = "eks-alb-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id  

  health_check {
    interval            = 70
    path                = "/index.html"
    port                = 80
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 60
  }
}

resource "aws_lb_listener_rule" "eks_alb_rule" {
  listener_arn = aws_lb_listener.eks_alb_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.eks_alb_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/app/*"]
    }
    }
  }

