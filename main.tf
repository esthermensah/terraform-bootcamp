terraform{
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 6.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

 resource "aws_key_pair" "dev_key"{
    key_name = "terraform-dev-key"
    public_key = file("terraform-key.pub")
 }

resource "aws_instance" "dev_server"{
    ami = "ami-05ffe3c48a9991133"
    instance_type = "t3.micro"

    key_name = aws_key_pair.dev_key.key_name
    vpc_security_group_ids = [
        aws_security_group.dev_sg.id
        ]
    user_data = <<-EOF
            #!/bin/bash
            yum update -y
            yum install -y httpd
            systemctl start httpd
            systemctl enable httpd
            echo "Hello from Terraform Web Server" > /var/www/html/index.html
            EOF


    tags = { 
        Name = "terraform-web-server"
    }

}

resource "aws_security_group" "dev_sg" {
    name = "terraform-dev-sg"
    description = "allow SSH and HTTP traffic"

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

     ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "All outbound traffic"
        from_port = 0 
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }


}



