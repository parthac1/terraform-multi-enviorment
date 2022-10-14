module "asg-App1" {
  
   source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.5.2"
 
  # insert the 10 required variables here
   

   name =  "APP1-asg"
    
  vpc_zone_identifier =  data.terraform_remote_state.vpc.outputs.private_subnets
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1
  target_group_arns =   module.alb.target_group_arns 
     
  launch_template_name        = "App1-lt"
  launch_template_description = "Complete launch template example"
  update_default_version      = true
  image_id      = data.aws_ami.amzlinux2.id
  instance_type =  var.instance_type
  user_data =    filebase64("${path.module}/app1-install.sh")
 security_groups  = [data.terraform_remote_state.Private_sg.outputs.Private_security_group_id]
  key_name =  var.key_name
  
   initial_lifecycle_hooks = [
    {
      name                 = "ExampleStartupLifeCycleHook"
      default_result       = "CONTINUE"
      heartbeat_timeout    = 60
      lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
      # This could be a rendered data resource
      notification_metadata = jsonencode({ "hello" = "world" })
    },
    {
      name                 = "ExampleTerminationLifeCycleHook"
      default_result       = "CONTINUE"
      heartbeat_timeout    = 180
      lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"
      # This could be a rendered data resource
      notification_metadata = jsonencode({ "goodbye" = "world" })
    }
  ]

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

   block_device_mappings  = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 20
        volume_type           = "gp2"
      } }
      ]
      scaling_policies = {
    avg-cpu-policy-greater-than-50 = {
      policy_type               = "TargetTrackingScaling"
      estimated_instance_warmup = 1200
      target_tracking_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ASGAverageCPUUtilization"
        }
        target_value = 50.0
      }
    }
      }

} 

module "asg-App2" {
  
   source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.5.2"
 
  # insert the 10 required variables here
   

   name =  "APP2-asg"
    
  vpc_zone_identifier =  data.terraform_remote_state.vpc.outputs.private_subnets
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1
  target_group_arns =   module.alb.target_group_arns 
     
  launch_template_name        = "App2-lt"
  launch_template_description = "Complete launch template example"
  update_default_version      = true
  image_id      = data.aws_ami.amzlinux2.id
  instance_type =  var.instance_type
  user_data =    filebase64("${path.module}/app2-install.sh")
 security_groups  = [data.terraform_remote_state.Private_sg.outputs.Private_security_group_id]
  key_name =  var.key_name
  
   initial_lifecycle_hooks = [
    {
      name                 = "ExampleStartupLifeCycleHook"
      default_result       = "CONTINUE"
      heartbeat_timeout    = 60
      lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
      # This could be a rendered data resource
      notification_metadata = jsonencode({ "hello" = "world" })
    },
    {
      name                 = "ExampleTerminationLifeCycleHook"
      default_result       = "CONTINUE"
      heartbeat_timeout    = 180
      lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"
      # This could be a rendered data resource
      notification_metadata = jsonencode({ "goodbye" = "world" })
    }
  ]

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

   block_device_mappings  = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 20
        volume_type           = "gp2"
      } }
      ]
      scaling_policies = {
    avg-cpu-policy-greater-than-50 = {
      policy_type               = "TargetTrackingScaling"
      estimated_instance_warmup = 1200
      target_tracking_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ASGAverageCPUUtilization"
        }
        target_value = 50.0
      }
    }
      }

} 



module "asg-App3" {
  
   source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.5.2"
 
  # insert the 10 required variables here
   

   name =  "APP3-asg"
    
  vpc_zone_identifier =  data.terraform_remote_state.vpc.outputs.private_subnets
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1
  target_group_arns =   module.alb.target_group_arns 
     
  launch_template_name        = "App3-lt"
  launch_template_description = "Complete launch template example"
  update_default_version      = true
  image_id      = data.aws_ami.amzlinux2.id   
  instance_type =  var.instance_type
  user_data =    base64encode(templatefile("app3-ums-install.tmpl",{rds_db_endpoint = data.terraform_remote_state.rds.outputs.db_instance_address}))    
 security_groups  = [data.terraform_remote_state.Private_sg.outputs.Private_security_group_id]
  key_name =  var.key_name
  
   initial_lifecycle_hooks = [
    {
      name                 = "ExampleStartupLifeCycleHook"
      default_result       = "CONTINUE"
      heartbeat_timeout    = 60
      lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
      # This could be a rendered data resource
      notification_metadata = jsonencode({ "hello" = "world" })
    },
    {
      name                 = "ExampleTerminationLifeCycleHook"
      default_result       = "CONTINUE"
      heartbeat_timeout    = 180
      lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"
      # This could be a rendered data resource
      notification_metadata = jsonencode({ "goodbye" = "world" })
    }
  ]

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

   block_device_mappings  = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 20
        volume_type           = "gp2"
      } }
      ]
      scaling_policies = {
    avg-cpu-policy-greater-than-50 = {
      policy_type               = "TargetTrackingScaling"
      estimated_instance_warmup = 1200
      target_tracking_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ASGAverageCPUUtilization"
        }
        target_value = 50.0
      }
    }
      }

} 


module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = ">= 4.0.0"

  domain_name  = trimsuffix(data.aws_route53_zone.my_hosted_zone.name ,"." )
  zone_id      =  data.aws_route53_zone.my_hosted_zone.zone_id

  subject_alternative_names = [
    "*.mycloudcomputing.in"

  ]

   

  tags = {
    Name = "mycloudcomputing.in"
  }
}

resource "aws_route53_record" "App1_Record" {
  zone_id = data.aws_route53_zone.my_hosted_zone.zone_id
  name    = "app1.mycloudcomputing.in"
  type    = "A" 
  alias  {
     name =  module.alb.lb_dns_name
     zone_id = module.alb.lb_zone_id
        
    evaluate_target_health =  true
  }
}

resource "aws_route53_record" "App2_Record" {
  zone_id = data.aws_route53_zone.my_hosted_zone.zone_id
  name    = "app2.mycloudcomputing.in"
  type    = "A" 
  alias  {
     name =  module.alb.lb_dns_name
     zone_id = module.alb.lb_zone_id
        
    evaluate_target_health =  true
  }
}

resource "aws_route53_record" "App3_Record" {
  zone_id = data.aws_route53_zone.my_hosted_zone.zone_id
  name    = "app3.mycloudcomputing.in"
  type    = "A" 
  alias  {
     name =  module.alb.lb_dns_name
     zone_id = module.alb.lb_zone_id
        
    evaluate_target_health =  true
  }
}



module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.0.0"
    
     
   

  load_balancer_type = "application"

  vpc_id          =  data.terraform_remote_state.vpc.outputs.vpc_id
  security_groups = [data.terraform_remote_state.alb_sg.outputs.alb_security_group_id]
  subnets          = [
   data.terraform_remote_state.vpc.outputs.public_subnets[0] ,
  data.terraform_remote_state.vpc.outputs.public_subnets[1] 

  ]

  #   # See notes in README (ref: https://github.com/terraform-providers/terraform-provider-aws/issues/7987)
  #   access_logs = {
  #     bucket = module.log_bucket.s3_bucket_id
  #   }

  http_tcp_listeners = [
    # Forward action is default, either when defined or undefined
    {
      port               = 80
      protocol           = "HTTP"
     action_type        = "redirect"
       redirect =  {
         port =  "443"
         protocol   = "HTTPS"
         status_code =  "HTTP_301"

       }

    }
   
  ]


  

  target_groups = [
    {
      name_prefix          = "App1"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      


} ,
     {
      name_prefix          = "App2"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app2/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      


} ,
    {
      name_prefix          = "App3"
      backend_protocol     = "HTTP"
      backend_port         = 8080
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/login"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      
      stickiness = {
        enabled = true
        cookie_duration = 86400
        type = "lb_cookie"
      }

} 

     

]

  
  https_listeners =   [
     {
     port =  443
     porotcol =  "HTTPS"
     certificate_arn =  module.acm.acm_certificate_arn
     action_type =  "fixed-response"
     fixed_response =  {
             content_type = "text/plain"
             message_body =  "Fixed Static message - for Root Context"
             status_code =  "200" 
               }
     }

  ]

    https_listener_rules = [
    # Rule-1: /app1* should go to App1 EC2 Instances
    { 
      https_listener_index = 0
      priority = 1
      actions = [
        {
          type               = "forward"
          target_group_index = 0
        }
      ]
      conditions = [{
       # path_patterns = ["/app1*"]
       host_headers = [var.app1_dns_name]
      }]
    }, 
        { 
      https_listener_index = 0
      priority = 2
      actions = [
        {
          type               = "forward"
          target_group_index = 1
        }
      ]
      conditions = [{
         # path_patterns = ["/app2*"]
       host_headers = [var.app2_dns_name]
      }]
    }  ,   { 
      https_listener_index = 0
      priority = 3
      actions = [
        {
          type               = "forward"
          target_group_index = 2
        }
      ]
      conditions = [{
       # path_patterns = ["/app3*"]
       host_headers = [var.app3_dns_name]
      }]
    } ]
      
    }
    