

 resource "aws_key_pair" "dev_key"{
    key_name = "terraform-dev-key"
    public_key = file("terraform-key.pub")
 }