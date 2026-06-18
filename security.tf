

resource "aws_key_pair" "dev_key" {
  key_name   = "terraform-dev-key"
  public_key = file("terraform-key.pub")
}


resource "aws_security_group" "dev_sg" {
  name        = "terraform-dev-sg"
  vpc_id = module.vpc.vpc_id
  description = "allow SSH and HTTP traffic"

  ingress {
    description = "SSH from my IP address only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["154.161.1.123/32"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}

