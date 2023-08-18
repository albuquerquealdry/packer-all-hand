source "amazon-ebs" "ubuntu" {
  ami_name      = "kidboo-ami"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "shell" {
  environment_vars = [
    "FOO=hello world",
  ]
  inline = [
    "echo Installing Nginx",
    "sudo apt-get update",
    "sudo apt-get install -y docker.io",
    "sudo su",
    "systemctl start docker",
    "docker run --name some-nginx -d -p 8080:80 some-content-nginx"
  ]
}
}