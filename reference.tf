provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "myec2" {
  ami           = "ami-08e4e35cccc6189f4"
  instance_type = "t2.micro"
}

resource "aws_eip" "myeip" {
  vpc = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.myec2.id
  allocation_id = aws_eip.myeip.id

}

resource "aws_security_group" "allow_tls" {
  name = "TF-SG"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${aws_eip.myeip.public_ip}/32"]
  }
}