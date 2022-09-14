resource "aws_instance" "ec2teste" {
  ami                         = var.AMI["amazon"]
  instance_type               = var.INSTANCE_TYPE[0]
  key_name                    = "oi"
  subnet_id                   = ""
  vpc_security_group_ids      = [""]
  associate_public_ip_address = true
  availability_zone           = "us-east-1b"


  root_block_device {
    encrypted             = true
    delete_on_termination = true
    volume_size           = 20
    volume_type           = var.VOLUME_TYPE[0]
  }

  tags = {
    Name = "instancia teste"
    # Insira o nome da instância de sua preferência.
  }

  /*
  provisioner "remote-exec" {
    inline = [
        "sudo yum update -y",
        "sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2",
        "sudo yum install -y httpd mariadb-server",
        "sudo systemctl start httpd",
        "sudo systemctl enable httpd",
        "sudo usermod -a -G apache ec2-user",
        "sudo chown -R ec2-user:apache /var/www",
        "sudo chmod 2775 /var/www"   

 
    ]

   connection {
    host = self.public_ip
    type = "ssh"
    user = "ec2-user"
    private_key = file ("path/oi.pem")

   }

  }

*/
}

resource "aws_eip" "ec2" {
  vpc = true
}


resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.ec2teste.id
  allocation_id = aws_eip.ec2.id
}


/*
module "ec2" {
  source = "../modules/ec2"
  name = var.NAME
  AMI = var.AMI
  INSTANCE_TYPE = var.INSTANCE_TYPE
  VOLUME_TYPE = var.VOLUME_TYPE
}*/