# Grupo de segurança para o Web App
resource "aws_security_group" "web_app_sg" {
  vpc_id = aws_vpc.dev_vpc.id  # Associa o grupo de segurança à VPC criada

  

  # Permissão de entrada (Ingress) para HTTP (porta 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permite acesso HTTP de qualquer IP externo
  }

  # Permissão de entrada (Ingress) para HTTPS (porta 443)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permite acesso HTTPS de qualquer IP externo
  }

  # Permissão de entrada (Ingress) para SSH (porta 22) - limitado a IP específico
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["179.100.49.140/32"] # Substitua por seu IP público para acesso SSH
  }

  # Permissões de saída (Egress) - permite saída para qualquer destino
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-web-app-sg"
  }
}

# Instância EC2 para o Web App
resource "aws_instance" "web-app-instance" {
  ami           = "ami-0794e5fde729305cd" # Substitua pelo ID da AMI desejada (ex. Amazon Linux ou Ubuntu)
  instance_type = "t2.micro"              # Usando a camada gratuita
  subnet_id     = aws_subnet.public_subnet.id # Coloca a instância na sub-rede pública
  key_name      = "ssh-key"           # Nome da sua chave SSH configurada na AWS

  # Associando o grupo de segurança ao Web App
    security_groups = [aws_security_group.web_app_sg.id]


  tags = {
    Name = "web-app-instance"
  }
}