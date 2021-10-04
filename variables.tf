variable "aws_region" {
  description = "AWS region."
  default     = "us-east-1"
}

variable "aws_availability_zone" {
  description = "AWS AZ."
  default     = "us-east-1d"
}

variable "key_name" {
  description = " SSH keys"
  default     =  "waok2"
}

variable "instance_type" {
  description = "instance type"
  default     =  "t2.micro"
}