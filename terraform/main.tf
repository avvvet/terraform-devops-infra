provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Allow Jenkins UI and Agent communication"

  # Allow SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Jenkins UI (8080)
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Jenkins Agent connection (50000)
  ingress {
    from_port   = 50000
    to_port     = 50000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins_server" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.ssh_key  
  security_groups = [aws_security_group.jenkins_sg.name]

  tags = {
    Name = "JenkinsServer"
  }

  # Install Docker and run Jenkins containers
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y docker.io",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo usermod -aG docker $USER",

      # Run Jenkins Controller
      "sudo docker run -d --name jenkins-controller --restart always -u root -p 8080:8080 -p 50000:50000 -v $HOME/jenkins_home:/var/jenkins_home jenkins/jenkins:lts",
      
      # Wait for Jenkins to initialize
      "sleep 60",

      # output jenkins initial admin secret
      "echo '###### JENKINS INITIAL ADMIN PASSWORD ######'",
      "sudo docker exec jenkins-controller cat /var/jenkins_home/secrets/initialAdminPassword",
      "echo '############################################'",


      # manually deploy docker agent node
      
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("../grace.pem")
    host        = self.public_ip
  }
}

