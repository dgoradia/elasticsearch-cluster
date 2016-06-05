resource "aws_instance" "private" {
  count = 3
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "m4.xlarge"
  subnet_id = "${aws_subnet.private.id}"
  vpc_security_group_ids = ["${aws_security_group.default.id}", "${aws_security_group.private.id}"]
  key_name = "${aws_key_pair.deploy.key_name}"
  private_ip = "${cidrhost(aws_subnet.private.cidr_block,  (4 + count.index))}"
  user_data = "${file("cloud-config/es-node.yml")}"
  tags {
    Name = "fd-elasticsearch"
  }
  lifecycle {
    create_before_destroy = true
  }
}
