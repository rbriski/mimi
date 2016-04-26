// EIP of web server
output "address" {
    value = "${aws_eip.hugo.public_ip}"
}