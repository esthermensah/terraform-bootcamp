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
    public_key = file("terraform.pub")
 }

resource "aws_instance" "dev_server"{
    ami = "ami-05ffe3c48a9991133"
    instance_type = "t3.micro"

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