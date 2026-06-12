resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "dev_bucket" {
  bucket = "esther-terraform-bucket-${random_id.suffix.hex}"

  tags = {
    Name = "terraform-dev-bucket"
  }
}