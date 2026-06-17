

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
