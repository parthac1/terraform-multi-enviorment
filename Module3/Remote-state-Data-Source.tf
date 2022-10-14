data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket =  "terraform-aws-state-files"
     key  =  "terraform-state-files/module1-vpc/-vpc.tfstate"
     region =   "us-east-1"
    }
  

  
  }


data "terraform_remote_state" "Private_sg" {
  backend = "s3"

  config = {
    bucket =  "terraform-aws-state-files"
     key  =  "terraform-state-files/module1-vpc/-vpc.tfstate"
     region =   "us-east-1"
    }
  

  
  }


data "terraform_remote_state" "alb_sg" {
  backend = "s3"

  config = {
    bucket =  "terraform-aws-state-files"
     key  =  "terraform-state-files/module1-vpc/-vpc.tfstate"
     region =   "us-east-1"
    }
  

  
  }

data "terraform_remote_state" "RDS_sg" {
  backend = "s3"

  config = {
    bucket =  "terraform-aws-state-files"
     key  =  "terraform-state-files/module1-vpc/-vpc.tfstate"
     region =   "us-east-1"
    }
  

  
  }

  data "terraform_remote_state" "acm" {
  backend =  "s3"
  config = {
    bucket =  "terraform-aws-state-files"
     key  =  "terraform-state-files/module1-vpc/-vpc.tfstate"
     region =   "us-east-1"
    }
    
  }



  data "terraform_remote_state" "rds" {
    backend =  "s3"
    config = {
    bucket =  "terraform-aws-state-files"
     key  =  "terraform-state-files/module2-rds/rds.tfstate"
     region =   "us-east-1"
    }
    
  }