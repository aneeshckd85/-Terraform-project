# terraform {
#   required_providers {
#    aws ={
#     source = "hashicorp/aws"
#     version = "~>5.0"
#    }
#   }
# }

# #Configure aws Provider
# provider "aws" {
#   region = "ap-south-1"
  
# }


# # Create VPC
# resource "aws_vpc" "webapp-project-vpc" {
#     cidr_block = "10.10.0.0/16"
#     tags ={
#         Name = "webapp-project-VPC"
#     }
  
# }

# # Create subnet

# resource "aws_subnet" "webapp-project-subnet1a" {
#     vpc_id = aws_vpc.webapp-project-vpc.id
#     cidr_block = "10.10.0.0/24"
#     availability_zone = "ap-south-1a"
#     map_public_ip_on_launch = true
#   tags = {
#     name = "webapp-project-subnet1a"
#   }
# }

# resource "aws_subnet" "webapp-project-subnet1b" {
#     vpc_id = aws_vpc.webapp-project-vpc.id
#     cidr_block = "10.10.1.0/24"
#     availability_zone = "ap-south-1b"
#     map_public_ip_on_launch = true
#   tags = {
#     name = "webapp-project-subnet1b"
#   }
# }

# resource "aws_subnet" "webapp-project-subnet1c" {
#     vpc_id = aws_vpc.webapp-project-vpc.id
#     cidr_block = "10.10.2.0/24"
#     availability_zone = "ap-south-1c"
    
#   tags = {
#     name = "webapp-project-subnet1c"
#   }
# }

# resource "aws_subnet" "webapp-project-subnet1d" {
#     vpc_id = aws_vpc.webapp-project-vpc.id
#     cidr_block = "10.10.3.0/24"
#     availability_zone = "ap-south-1c"
    
#   tags = {
#     name = "webapp-project-subnet1d"
#   }
# }

# #Create the EC2 Servers

# resource "aws_instance" "webapp-project-Mechine1" {
# ami = "ami-0ad21ae1d0696ad58"
# instance_type = "t2.micro"
# key_name = aws_key_pair.project_key.id
# subnet_id = aws_subnet.webapp-project-subnet1a.id
# vpc_security_group_ids = [aws_security_group.project_allow_22_80]
# user_data = filebase64("userdata1.sh")
# tags = {
#     Name = "project_mechine1"
# }
# }

# resource "aws_instance" "webapp-project-Mechine2" {
# ami = "ami-0ad21ae1d0696ad58"
# instance_type = "t2.micro"
# key_name = aws_key_pair.project_key.id
# subnet_id = aws_subnet.webapp-project-subnet1b.id
# vpc_security_group_ids = [aws_security_group.project_allow_22_80]
# user_data = filebase64("userdata1.sh")
# tags = {
#     Name = "project_mechine2"
# }
# }

# #create key pair
# resource "aws_key_pair" "project_key" {
# key_name   = "Webapp_key"
#   public_key ="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpNcLSjbXYK3w4/7ddwd4jaL6MD0G3clKaoe6coLTgI Anas@DESKTOP-OUBGSPJ"
# }
  
# #Create the Security group
# resource "aws_security_group" "project_allow_22_80" {
#     name = "project-20-80"
#     description = "allow TCL inbount 20 and 80 port"
#     vpc_id = aws_vpc.webapp-project-vpc.id
#     tags ={
#         name ="Pro_allow_22_80"
#     }
  
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_project_tls_22" {
#   security_group_id = aws_security_group.project_allow_22_80.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 22
#   ip_protocol       = "tcp"
#   to_port           = 22
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_proj_tls_80" {
#   security_group_id = aws_security_group.project_allow_22_80.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 80
#   ip_protocol       = "tcp"
#   to_port           = 80
# }
# resource "aws_vpc_security_group_egress_rule" "project_allow_outbound" {
#   security_group_id = aws_security_group.project_allow_22_80.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1" 
# }

# resource "aws_vpc_security_group_egress_rule" "project_allow_outbound_ipv6" {
#   security_group_id = aws_security_group.allow_22_80.id
#   cidr_ipv6         = "::/0"
#   ip_protocol       = "-1" 
# }

# #Create inetnet GW
# resource "aws_internet_gateway" "project_internet_GW" {
#   vpc_id = aws_vpc.webapp-project-vpc.id
#   tags={
#     name ="project-internet-GW"
#   }
# }

# #Create RT
# resource "aws_route_table" "Project_public_RT" {
#   vpc_id = aws_vpc.webapp-project-vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.project_internet_GW.id
#   }

#   tags = {
#     Name = "Project_public_RT"
#   }
# }

# resource "aws_route_table" "Project_private_RT" {
#   vpc_id = aws_vpc.webapp-project-vpc.id

#   route {
    
#     gateway_id = aws_internet_gateway.project_internet_GW.id
#   }

#   tags = {
#     Name = "Project_private_RT"
#   }
# }


# #Create route table association

# resource "aws_route_table_association" "PR_RT-associ_subnet_1_public" {
#   subnet_id      = aws_subnet.webapp-project-subnet1a.id
#   route_table_id = aws_route_table.Project_public_RT
# }

# resource "aws_route_table_association" "PR_RT-associ_subnet_2_public" {
#   subnet_id      = aws_subnet.webapp-project-subnet1b.id
#   route_table_id = aws_route_table.Project_public_RT
# }

# resource "aws_route_table_association" "PR_RT-associ_subnet_3_private" {
#   subnet_id      = aws_subnet.webapp-project-subnet1c.id
#   route_table_id = aws_route_table.Project_private_RT.id
# }
# resource "aws_route_table_association" "PR_RT-associ_subnet_4_private" {
#   subnet_id      = aws_subnet.webapp-project-subnet1d.id
#   route_table_id = aws_route_table.Project_private_RT.id
# }
# #Create SG for ALB
# resource "aws_security_group" "project_allow_80" {
#     name = "project-80"
#     description = "allow TCL inbount 80 port"
#     vpc_id = aws_vpc.webapp-project-vpc.id
#     tags ={
#         name ="Pro_allow_80"
#     }
  
# }


# resource "aws_vpc_security_group_ingress_rule" "allow_proj_tls_80-1" {
#   security_group_id = aws_security_group.project_allow_80.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 80
#   ip_protocol       = "tcp"
#   to_port           = 80
# }
# resource "aws_vpc_security_group_egress_rule" "project_allow_outbound-1" {
#   security_group_id = aws_security_group.project_allow_80.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1" 
# }

# resource "aws_vpc_security_group_egress_rule" "project_allow_outbound_ipv6-1" {
#   security_group_id = aws_security_group.project_allow_80.id
#   cidr_ipv6         = "::/0"
#   ip_protocol       = "-1" 

# #Create target group
# resource "aws_lb_target_group" "project_target_group" {
#   name     = "project-target-group"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.webapp-project-vpc.id
# }

# resource "aws_lb_target_group_attachment" "Project_target_group_attach1" {
#   target_group_arn = aws_lb_target_group.project_target_group.arn
#   target_id        = aws_instance.webapp-project-Mechine1.id
#   port             = 80
# }

# resource "aws_lb_target_group_attachment" "Project_target_group_attach2" {
#   target_group_arn = aws_lb_target_group.project_target_group.arn
#   target_id        = aws_instance.webapp-project-Mechine2
#   port             = 80
# }

# #Create ALB (Load Balance)
# resource "aws_lb" "Project_LB" {
#   name               = "webapp_project_alb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.project_allow_80.id]
#   subnets            = []

#   }

#   tags = {
#     Environment = "production"
#   }
# }
