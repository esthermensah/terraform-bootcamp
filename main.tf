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

resource "aws_instance" "dev_server"{
    ami = "ami-05ffe3c48a9991133"
    instance_type = "t3.micro"
    tags = { 
        Name = "terraform-dev-server"
    }
}