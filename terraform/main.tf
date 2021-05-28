resource "aws_instance" "AllureAwsInstance" {
  ami             = "ami-0ff338189efb7ed37"
  instance_type   = "t3.micro"
  security_groups = ["allure"]
  associate_public_ip_address = true
  key_name = "allure"
  tags = {
    "Name" = "EC2_Instance_Terraform"
  }
  provisioner "file" {
    source      = "docker-compose.yml"
    destination = "docker-compose.yml"

    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("./allure.pem")
      host = aws_instance.AllureAwsInstance.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable\"",
      "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic test\"",
      "sudo apt update",
      "sudo apt-cache policy docker-ce",
      "sudo apt install -y docker-ce",
      "sudo usermod -aG docker ubuntu"
    ]
    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("./allure.pem")
      host = aws_instance.AllureAwsInstance.public_ip
    }
  }

    provisioner "remote-exec" {
    inline = [
      "sudo curl -L \"https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose",
      "export INSTANCE_IP=\"$(curl http://checkip.amazonaws.com)\"",
      "mkdir projects",
      "docker-compose up -d"
    ]
    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("./allure.pem")
      host = aws_instance.AllureAwsInstance.public_ip
    }
  }
}
