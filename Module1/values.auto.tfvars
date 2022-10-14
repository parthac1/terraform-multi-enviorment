name =  "MyVPC"
CIDR  =  "172.16.0.0/16"
my_azs =  ["us-east-1a" ,  "us-east-1b"]
private_subnets =  ["172.16.1.0/24" ,"172.16.2.0/24" ]
public_subnets = ["172.16.3.0/24" ,"172.16.4.0/24" ]
database_subnets = ["172.16.5.0/24" ,"172.16.6.0/24" ]


key_name =  "DemoKeyPair"
instance_type =  "t2.micro"