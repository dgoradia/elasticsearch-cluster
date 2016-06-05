resource "aws_key_pair" "deploy" {
  key_name   = "deploy-fd-elasticsearch"
  public_key = "${file("ssh/insecure-deploy.pub")}"
}
