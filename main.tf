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
 # vpc_id = aws_instance.myvm1
  ingress {
    #cidr_blocks = [ "value" ]
    #description = "value"
    from_port = 22
    #ipv6_cidr_blocks = [ "value" ]
    #prefix_list_ids = [ "value" ]
    protocol = "6"
    #security_groups = [ "value" ]
    #self = false
    to_port = 22
  }
  egress  {
    #cidr_blocks = [ "value" ]
    #description = "value"
    from_port = 1
    #ipv6_cidr_blocks = [ "value" ]
    #prefix_list_ids = [ "value" ]
    protocol = "tcp"
    #security_groups = [ "value" ]
    #self = false
    to_port = 1
    cidr_blocks=["0.0.0.0/0"]
  } 
}