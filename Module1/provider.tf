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
     bucket =  "terraform-aws-state-files"
     key = "terraform-state-files/module1-vpc/-vpc.tfstate"
     region =  "us-east-1"
     dynamodb_table =  "module1-vpc"
   
   }



}
    provider "aws" {
        region = "us-east-1"
          
    }

