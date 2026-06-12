terraform{
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 6.0"
        }
    }
}

provider "aws" {
    region = var.region
}

 resource "aws_key_pair" "dev_key"{
    key_name = "terraform-dev-key"
    public_key = file("terraform-key.pub")
 }

resource "aws_instance" "dev_server"{
    ami = "ami-05ffe3c48a9991133"

    instance_type = var.instance_type

    subnet_id = aws_subnet.public_a.id


    key_name = aws_key_pair.dev_key.key_name
    iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
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
    vpc_id = aws_vpc.main.id
    description = "allow SSH and HTTP traffic"

    ingress {
        description = "SSH from my IP address only"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["154.161.49.236/32"]
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































