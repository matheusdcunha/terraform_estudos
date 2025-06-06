data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name       = "Primeiro Servidor"
    Env        = "develop"
    Plataforma = data.aws_ami.ubuntu.platform_details
  }
}

data "terraform_remote_state" "aula_workspace" {
  backend = "s3"

  config = {
    bucket         = "descomplicando-terraform-vasco"
    key            = "aula_workspace"
    region         = "us-east-2"
  }
}
