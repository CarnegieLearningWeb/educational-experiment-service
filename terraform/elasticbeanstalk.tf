resource "aws_elastic_beanstalk_application" "app" {
  name        = "app"
  description = "app"
}

resource "aws_elastic_beanstalk_environment" "app-prod" {
  name                = "app-prod"
  application         = aws_elastic_beanstalk_application.app.name
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.14.3 running Docker 18.09.9-ce"
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = aws_vpc.main.id
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${aws_subnet.main-private-1.id},${aws_subnet.main-private-2.id}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "false"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.app-ec2-role.name
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.app-prod.id
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = aws_key_pair.mykeypair.id
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = aws_iam_role.elasticbeanstalk-service-role.name
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "public"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = "${aws_subnet.main-public-1.id},${aws_subnet.main-public-2.id}"
  }
  setting {
    namespace = "aws:elb:loadbalancer"
    name      = "CrossZone"
    value     = "true"
  }
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSize"
    value     = "30"
  }
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSizeType"
    value     = "Percentage"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "Availability Zones"
    value     = "Any 2"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "1"
  }
  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateType"
    value     = "Health"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_USERNAME"
    value     = aws_db_instance.postgres.username
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_PASSWORD"
    value     = aws_db_instance.postgres.password
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_DB_NAME"
    value     = aws_db_instance.postgres.name
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_HOSTNAME"
    value     = split( ":", aws_db_instance.postgres.endpoint)[0]
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_PORT"
    value     = split( ":", aws_db_instance.postgres.endpoint)[1]
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "APP_BANNER"
    value     = true
  }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="APP_HOST" 
    value = "localhost"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="APP_NAME" 
    value = "A/B Testing Backend"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="APP_PORT" 
    value = 3030
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="APP_ROUTE_PREFIX" 
    value = "/api"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="APP_SCHEMA" 
    value = "http"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="AUTH_CHECK" 
    value = false
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="AWS_REGION" 
    value = "eu-west-1"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="CONTROLLERS" 
    value = "src/api/controllers/**/*Controller.ts"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="GOOGLE_CLIENT_ID" 
    value = "135765367152-pq4jhd3gra10jda9l6bpnmu9gqt48tup.apps.googleusercontent.com"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="HOST_URL" 
    value = "http://upgrade-development.us-east-1.elasticbeanstalk.com/api"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="INTERCEPTORS" 
    value = "src/api/interceptors/**/*Interceptor.ts"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="LOG_LEVEL" 
    value = "debug"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="LOG_OUTPUT" 
    value = "dev"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="MIDDLEWARES" 
    value = "src/api/middlewares/**/*Middleware.ts"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="MONITOR_ENABLED" 
    value = true
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="MONITOR_PASSWORD" 
    value = 1234
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="MONITOR_ROUTE" 
    value = "/monitor"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="MONITOR_USERNAME" 
    value = "admin"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="SCHEDULER_STEP_FUNCTION" 
    value = aws_sfn_state_machine.ExperimentSchedular-development.id
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="SWAGGER_API" 
    value = "src/api/controllers/*.ts"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="SWAGGER_ENABLED" 
    value = true
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="SWAGGER_FILE" 
    value = "api/swagger.json"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="SWAGGER_PASSWORD" 
    value = 1234
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="SWAGGER_ROUTE" 
    value = "/swagger"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="SWAGGER_USERNAME" 
    value = "admin"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="TOKEN_SECRET_KEY" 
    value = "carnegielearning"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="TYPEORM_CONNECTION" 
    value = "postgres"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="TYPEORM_ENTITIES" 
    value = "src/api/models/**/*.ts"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="TYPEORM_ENTITIES_DIR" 
    value = "src/api/models"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="TYPEORM_FACTORY" 
    value = "src/database/factories/**/*.factory.ts"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="TYPEORM_LOGGER" 
    value = "advanced-console"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="TYPEORM_LOGGING" 
    value = "all"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="TYPEORM_MIGRATIONS" 
    value = "src/database/migrations/**/*.ts"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="TYPEORM_MIGRATIONS_DIR" 
    value = "src/database/migrations"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="TYPEORM_SEED" 
    value = "src/database/seeds/**/*.seed.ts"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      ="TYPEORM_SYNCHRONIZE" 
    value = true
  }
}
