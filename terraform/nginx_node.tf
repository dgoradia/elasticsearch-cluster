resource "aws_instance" "public" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public.id}"
  vpc_security_group_ids = ["${aws_security_group.default.id}", "${aws_security_group.public.id}"]
  key_name = "${aws_key_pair.deploy.key_name}"
  provisioner "remote-exec" {
    inline = [
    "echo ${aws_elb.private.dns_name} | sudo tee /etc/elb_dns_name",
    ]
    connection {
      user = "ubuntu"
      private_key = "${file("ssh/insecure-deploy")}"
    }
  }
  user_data = "${file("cloud-config/nginx.yml")}"
  tags {
    Name = "fd-nginx"
  }
}
