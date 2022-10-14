terraform   {
    
     
 
  required_providers {
    aws = {
      source = "hashicorp/aws"
        version = ">= 4.12.0"  
    }
  

      null =  {
        source = "hashicorp/null"
        version =  " ~> 3.1.1"
      }
  }
   
   backend "s3" {
     bucket =   "terraform-aws-state-files"
     key = "terraform-state-files/module3-asg-alb/alb-asg.tfstate"
     region =  "us-east-1"
     dynamodb_table =  "module3-alb-asg"
   }

}


    provider "aws" {
        region = "us-east-1"
         
    }