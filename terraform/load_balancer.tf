resource "aws_elb" "private" {
  name = "elasticsearch-private"
  subnets = ["${aws_subnet.private.id}"]
  internal = true
  instances = ["${aws_instance.private.*.id}"]
  listener {
    lb_protocol = "${var.elb_lb_protocol}"
    lb_port = "${var.elb_lb_port}"
    instance_protocol = "${var.elb_instance_protocol}"
    instance_port = "${var.elb_instance_port}"
  }
  security_groups = ["${aws_security_group.default.id}", "${aws_security_group.private.id}"]
  health_check {
    healthy_threshold = "${var.elb_check_healthy}"
    unhealthy_threshold = "${var.elb_check_unhealthy}"
    target = "${var.elb_check_target}"
    interval = "${var.elb_check_interval}"
    timeout = "${var.elb_check_timeout}"
  }
  lifecycle {
    create_before_destroy = true
  }
}
