
resource "aws_security_group" "internet_facing" {
  name        = "${var.name}-internet_facing-security-group"
  description = "intenet_facing"
  vpc_id      = (aws_vpc.Bruno.id)

    tags = {
    Name = "${var.name}-internet_facing-security-group"
  }


  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }


    ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }


  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
}

