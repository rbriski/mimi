resource "template_file" "install" {
  template = "${file("${path.module}/scripts/install.sh.tpl")}"
}

resource "aws_instance" "hugo" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = [
    "${aws_security_group.main.id}",
    "${aws_security_group.nat.id}",
    "${aws_security_group.web.id}",
  ]
  tags {
    Name = "Hugo (mimi)"
  }
  subnet_id = "${aws_subnet.hugo.id}"
  user_data = "${template_file.install.rendered}"
}

resource "aws_eip" "hugo" {
  instance = "${aws_instance.hugo.id}"
  vpc      = true
}