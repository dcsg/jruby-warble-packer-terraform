output "address" {
  value = "${aws_instance.app_instance.public_dns}"
}

output "ip" {
  value = "${aws_instance.app_instance.public_ip}"
}
