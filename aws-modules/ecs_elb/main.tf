
resource "aws_ecs_cluster" "bruno" {
  name = "Cluster-Name"

  tags = {
    "copilot-application" = "app"
    "copilot-environment" = "production"
  }

  configuration {
    execute_command_configuration {
      logging = "DEFAULT"
    }
  }
}


resource "aws_ecs_task_definition" "bruno" {
  container_definitions    = file("./task-definition.json")
  execution_role_arn       = "arn:aws:iam:.........."
  task_role_arn            = "arn:aws:iam:.........."
  family                   = "family"
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "2048"
  requires_compatibilities = ["FARGATE"]

}


resource "aws_cloudwatch_log_group" "log" {
  name              = "/copilot/name"
  retention_in_days = 30

  tags = {
    "copilot-application" = "app"
    "copilot-environment" = "production"
    "copilot-service"     = "svc"
  }
}



resource "aws_ecs_service" "bruno" {
  name                              = "name"
  cluster                           = (aws_ecs_cluster.bruno.id)
  task_definition                   = "taskdefinition"
  launch_type                       = "FARGATE"
  scheduling_strategy               = "REPLICA"
  desired_count                     = 1
  enable_execute_command            = true
  propagate_tags                    = "SERVICE"
  health_check_grace_period_seconds = 60

  network_configuration {
    subnets          = [var.subnet_id1a, var.subnet_id1b]
    assign_public_ip = false
    security_groups  = [(var.sg-env)]
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }



  load_balancer {
    target_group_arn = (aws_lb_target_group.bruno.id)
    container_name   = "name"
    container_port   = 3000
  }


  service_registries {
    container_port = 3000
    port           = 3000
    registry_arn   = "arn:aws:.............."
  }


  tags = {
    "copilot-application" = "app"
    "copilot-environment" = "production"
    "copilot-service"     = "svc"
  }

}



#                                                     >>>  Criação de Cluster ECR   <<< 



resource "aws_ecr_repository" "bruno" {
  name                 = "name"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

  tags = {
    copilot-application = "app"
    copilot-service     = "svc"
  }

}



#           >>> Criação de Application Load Balancer, Listeners (Porta 80 Redirect para 443 e 444 forward para Target Group) e Target Group   <<< 




resource "aws_lb" "bruno" {
  name                       = "lbname"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.sg-lb]
  subnets                    = [var.subnet_id_pub1b, var.subnet_id_pub1a]
  enable_deletion_protection = false

  tags = {
    "copilot-application" = "app"
    "copilot-environment" = "production"
  }


  subnet_mapping {
    subnet_id = "subnet-0210e31cf9b4182fc"
  }
  subnet_mapping {
    subnet_id = "subnet-067d1b99b04cf9ba5"
  }

}


resource "aws_lb_target_group" "bruno" {
  name                   = "targetname"
  target_type            = "ip"
  port                   = 3000
  protocol               = "HTTP"
  vpc_id                 = "vpc-03b0db53bf66a9f0a"
  connection_termination = false
  deregistration_delay   = "60"

  tags = {
    "copilot-application" = "app"
    "copilot-environment" = "production"
    "copilot-service"     = "svc"
  }


  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }


  stickiness {
    cookie_duration = 86400
    enabled         = false
    type            = "lb_cookie"
  }


}

/*
resource "aws_lb_listener" "bruno" {

    load_balancer_arn          = (aws_lb.bruno.id)

    port                       = 443

    protocol                   = "HTTPS"

    certificate_arn = ""

    default_action {

        target_group_arn         = (aws_lb_target_group.bruno.id)

        type                     = "forward"

    }

}


resource "aws_lb_listener" "bruno1" {
  load_balancer_arn = (aws_lb.bruno.id)
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
  }
*/

resource "aws_lb_listener" "alb-listener" {

  load_balancer_arn = (aws_lb.bruno.id)

  port = 80

  protocol = "HTTP"

  default_action {

    target_group_arn = (aws_lb_target_group.bruno.id)

    type = "forward"

  }

}





#                                          >>> Criação do Global Acelerator   <<<


/*
resource "aws_globalaccelerator_accelerator" "bruno" {
  name            = "bruno"
  ip_address_type = "IPV4"
  enabled         = true
  
}


resource "aws_globalaccelerator_listener" "bruno" {
  accelerator_arn = (aws_globalaccelerator_accelerator.bruno.id)
  client_affinity = "SOURCE_IP"
  protocol        = "TCP"

  port_range {
    from_port = 80
    to_port   = 80
  }
}


resource "aws_globalaccelerator_endpoint_group" "bruno" {
  listener_arn = (aws_globalaccelerator_listener.bruno.id)

  endpoint_configuration {
    endpoint_id = (aws_lb.bruno.id)
    weight      = 100
  }
}
*/


#                                   >>>  Criação de Auto_Scaling para o Serviço ECS_Fargate  <<<


/*
resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 4
  min_capacity       = 1
  resource_id        = "service/${"liqi"}/${"liqi"}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}


resource "aws_appautoscaling_policy" "ecs_policy_memory" {
  name               = "memory-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
 
  target_tracking_scaling_policy_configuration {
   predefined_metric_specification {
     predefined_metric_type = "ECSServiceAverageMemoryUtilization"
   }
 
   target_value       = 80
  }
}

resource "aws_appautoscaling_policy" "ecs_policy_cpu" {
  name               = "cpu-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
 
  target_tracking_scaling_policy_configuration {
   predefined_metric_specification {
     predefined_metric_type = "ECSServiceAverageCPUUtilization"
   }
 
   target_value       = 60
  }
}*/

/*
module "ecs_elb" {
  source           = "../modules/ecs_elb"
  vpc_id           = (aws_vpc.bruno.id)
  name             = var.name
  subnet_id_pub1a  = (aws_subnet.public.id)
  subnet_id_pub1b  = (aws_subnet.public1.id)
  subnet_id1a      = (aws_subnet.private.id)
  subnet_id1b      = (aws_subnet.private1.id)
}*/