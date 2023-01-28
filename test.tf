provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0ff8a91507f77f867"
  instance_type = "t2.micro"

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y git",
      "sudo yum install -y httpd",
      "sudo service httpd start",
      "git clone https://github.com/devopsneelagiri/mywebsite.git",
      "sudo cp -r mywebsite/* /var/www/html/",
    ]
  }
}

resource "aws_security_group" "my_security_group" {
  name        = "my_security_group"
  description = "Allow incoming traffic on port 80"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
