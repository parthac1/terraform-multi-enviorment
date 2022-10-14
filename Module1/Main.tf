module "vpc" {
 source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.4"

  name = var.name
  cidr = var.CIDR
  single_nat_gateway =  true

  azs                 = var.my_azs
  private_subnets     =  var.private_subnets
  public_subnets      = var.public_subnets
  database_subnets    = var.database_subnets
 create_database_subnet_group =  true
 create_database_subnet_route_table =  true
 
 enable_dhcp_options =  true
 enable_dns_support  =  true
 enable_nat_gateway =   true
  

  private_subnet_tags   =  {
    Name = "Private Subnet"
  }
   public_subnet_tags   =  {
    Name = "Public Subnet"
  }
   database_subnet_tags   =  {
    Name = "database Subnet"
  }

  private_route_table_tags =  {
    Name = "Private Route table "
  }

  public_route_table_tags =  {
    Tag = "Public Route table "
  }
  
  database_route_table_tags =  {
    Tag = "database Route table "
  }
}




module "Bastion_sg" {
source  = "terraform-aws-modules/security-group/aws"
  version = "4.13.0"


  name        = "Bastion-sg"
  description = "Security group which is used as an argument in complete-sg"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]
  egress_rules = ["all-all"]
}

module "RDS_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.13.0"
  name        = "rdsdb-sg"
  description = "Access to MySQL DB for entire VPC CIDR Block"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]  
  tags =  {
         Name = "RDS_SG"
  }
}


module "Private_sg" {
source  = "terraform-aws-modules/security-group/aws"
  version = "4.13.0"


  name        = "Private-sg"
  description = "Security group which is used as an argument in complete-sg"
  vpc_id      = module.vpc.vpc_id
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules       = ["ssh-tcp" ,"http-80-tcp" , "http-8080-tcp" ]
  egress_rules = ["all-all"]

}

module "alb_sg" {
source  = "terraform-aws-modules/security-group/aws"
  version = "4.13.0"


  name        = "Alb-sg"
  description = "Security group which is used as an argument in complete-sg"
  vpc_id      = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp" ,"http-80-tcp" , "http-8080-tcp"]
  egress_rules = ["all-all"]

}

resource "aws_instance" "Bastion_server" {
 ami =  data .aws_ami.amzlinux2.id
 instance_type = var.instance_type 
 key_name =  var.key_name
 subnet_id = module.vpc.public_subnets[0]
 vpc_security_group_ids = [module.Bastion_sg.security_group_id]
 tags =  {
    Name =  "BastionServer"
 }

 associate_public_ip_address = true
}


resource "aws_eip" "lb" {
  instance = aws_instance.Bastion_server.id
  vpc      = true
}


resource "null_resource" "MyNullResource" {
 
    connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("DemoKeyPair.pem")
    host     =  aws_instance.Bastion_server.public_ip
  }
    
provisioner "file" {
  source      = "DemoKeyPair.pem"
  destination = "/home/ec2-user/DemoKeyPair.pem"

}

 provisioner "remote-exec" {
    inline = [
      "sudo chmod 400  /home/ec2-user/DemoKeyPair.pem "
    ]
  }
}








