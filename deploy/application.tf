terraform {
  required_version = ">= 0.9.3"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}

resource "aws_vpc" "public_web" {
  cidr_block = "10.0.0.0/16"

  tags {
    Name = "App"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = "${aws_vpc.public_web.id}"

  tags {
    Name = "App"
  }
}

resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.public_web.id}"


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gateway.id}"
  }

  tags {
    Name = "App"
  }
}
resource "aws_route_table_association" "eu-west-1a-public" {
  subnet_id = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.main.id}"
}

resource "aws_security_group" "allow_http" {
  vpc_id = "${aws_vpc.public_web.id}"
  name = "allow_http"
  description = "Allow http inbound traffic"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.public_web.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = true


  tags {
    Name = "App"
  }
}

resource "aws_instance" "app_instance" {
  ami = "${var.app_ami}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.allow_http.id}"]
  subnet_id = "${aws_subnet.public.id}"
  associate_public_ip_address = true
  key_name = "${var.aws_key_name}"
  user_data = "${file("user-data.sh")}"

  tags {
    Name = "App"
  }
}
