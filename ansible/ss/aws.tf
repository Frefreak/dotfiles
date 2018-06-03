provider "aws" {
  region     = "ap-northeast-1"
}

resource "aws_key_pair" "aws_key" {
  key_name   = "${var.hostname}"
  public_key = "${var.pubssh}"
}

resource "aws_instance" "arch" {
  ami           = "ami-8351b6fc"
  instance_type = "t2.micro"
  key_name      = "${var.hostname}"

}
