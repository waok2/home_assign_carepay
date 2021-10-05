terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = var.aws_region
}





##creating security group 
resource "aws_security_group" "carepay_nginx" {
  name        = "carepay_nginx"
  description = "security group for carepay_nginx"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

 

  tags= {
    Name = "carepay_nginx"
  }
}


## create EC2 instance
resource "aws_instance" "carepay-nginx" {
 ##ubuntu server ami
  ami           = "ami-09e67e426f25ce0d7"
  
  key_name = var.key_name
  instance_type = var.instance_type
  security_groups= [ "carepay_nginx"]
  ##uncomment if you want to specify availability zone 
  #availability_zone = var.aws_availability_zone
  

  tags = {
    Name = "carepay-home-assignment",
    Server-group = "carepay-nginx"

  }
}

### uncomment if you want to create a data disk attached to ec2
# ##creating a data disk
# resource "aws_ebs_volume" "carepay-data-disk" {
#   availability_zone = var.aws_availability_zone
#   size              = 1
#   tags= {
#     Name = "carepay-data-disk"
#   }
# }

# ##attaching 
# resource "aws_volume_attachment" "ebs_att" {
#   device_name = "/dev/sdh"
#   volume_id   = aws_ebs_volume.carepay-data-disk.id
#   instance_id = aws_instance.carepay-nginx.id
# }

# Create Elastic IP address
resource "aws_eip" "carepay-nginx" {
  vpc      = true
  instance = aws_instance.carepay-nginx.id
tags= {
    Name = "carepay-nginx"
  }
}
