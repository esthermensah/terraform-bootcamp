output "public_ip" {
    value = aws_instance.dev_server.public_ip
}

output "public_dns" {
    value = aws_instance.dev_server.public_dns
}

output "instance_id"{
    value = aws_instance.dev_server.id
}