module "vpc" {
  source = "./modules/vpc"

  az_a = var.az_a
  az_b = var.az_b
}

module "ec2" {
  source = "./modules/ec2"

  instance_type        = var.instance_type
  subnet_id            = module.vpc.public_subnet_a_id
  key_name             = aws_key_pair.dev_key.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  security_group_ids = [
    aws_security_group.dev_sg.id
  ]
}



