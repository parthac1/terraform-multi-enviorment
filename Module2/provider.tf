terraform   {
    
     
    required_providers {
      aws  = {
        source = "hashicorp/aws"
        version = ">= 3.0" 
      }
    
      null =  {
        source = "hashicorp/null"
        version =  " ~> 3.1.1"
      }
    }
   
   backend "s3" {
     bucket =   "terraform-aws-state-files"
     key = "terraform-state-files/module2-rds/rds.tfstate"
     region =  "us-east-1"
      dynamodb_table =  "module2-rds"
   
   }



}
    provider "aws" {
        region = "us-east-1"
         profile = "default"
    }