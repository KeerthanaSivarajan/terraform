
provider "aws" {
region = "ap-south-1"
access_key ="AKIA33JNFJSJ3NQQ3Z5V"
secret_key ="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"
}

resource "aws_security_group" "allow_all" {
  name        = "allow-all_traffic"
  description = "Allow all inbound and outbound traffic"
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example_instance" {
  ami       = "ami-0c84181f02b974bc3" 
  instance_type   = "t2.micro"
  key_name  ="Linux-instance"
  count="1"
  vpc_security_group_ids =[aws_security_group.allow_all.id]

  user_data = <<-EOF
               #!/bin/bash
              yum update -y
              yum install httpd -y
              service httpd start
              chkconfig httpd on
              echo "<html><body><h1>Test page.Hello Devops</h1></body></html>" > /var/www/html/index.html
              EOF

 tags ={
   name ="Exampleinstance"
}
}

