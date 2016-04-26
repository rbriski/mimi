resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags {
    Name = "hugo-vpc"
  }
}

/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "Hugo VPC"
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.default.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
    Name = "hugo-public-route-table"
  }
}

/* Public subnet */
resource "aws_subnet" "hugo" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.public_subnet_cidr_hugo}"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  depends_on = ["aws_internet_gateway.default"]
  tags {
    Name = "hugo-public-subnet-1b"
  }
}

/* Associate the routing table to public subnet */
resource "aws_route_table_association" "hugo" {
  subnet_id = "${aws_subnet.hugo.id}"
  route_table_id = "${aws_route_table.public.id}"
}