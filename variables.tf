variable "instance_type" {
  description = "EC2 intance type"
  type        = string
  default     = "t3.micro"
}


variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}


variable "az_a" {
  description = "Availability Zone A"
  default     = "us-east-1a"
}

variable "az_b" {
  description = "Availability Zone B"
  default     = "us-east-1b"
}