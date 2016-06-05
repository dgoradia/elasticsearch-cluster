output "proxy.public_dns" {
  value = "${aws_instance.public.public_dns}"
}

output "proxy.public_ip" {
  value = "${aws_instance.public.public_ip}"
}
