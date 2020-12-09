provider "aws" {
  region="ap-south-1"
}

resource "aws_instance" "myvm1" {
   instance_type = "t2.micro"
   ami = "ami-08f63db601b82ff5f"
   depends_on = [ "aws_security_group.first_group" ]  
}

resource "aws_s3_bucket" "first_bucket" {
  #bucket = "first_bucket"
  #acl = "private"
  # versioning = {
 #   enabled = true
 # }
}

resource "aws_eip" "my_eip" {
 depends_on= ["aws_instance.myvm1"] 
 instance = aws_instance.myvm1.id
}

resource "aws_security_group" "first_group" {
  name = "first_group"
  ingress {
    from_port = 0
    protocol = "tcp"
    to_port = 22
    cidr_blocks=["0.0.0.0/0"]
  }
  egress  {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks=["0.0.0.0/0"]
  } 
}