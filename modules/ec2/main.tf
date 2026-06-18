resource "aws_instance" "dev_server" {
  ami = "ami-05ffe3c48a9991133"

  instance_type = var.instance_type

  subnet_id = var.subnet_id

  key_name = var.key_name

  iam_instance_profile = var.iam_instance_profile

  vpc_security_group_ids = var.security_group_ids

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