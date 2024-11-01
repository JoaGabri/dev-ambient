# Configuração do Provedor AWS
provider "aws" {
  region = "sa-east-1"  # Região de São Paulo
}

# Definir um bloco terraform para controlar o backend e estado (opcional)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Opções Globais
variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "dev-environment"
}

output "vpc_id" {
  value = aws_vpc.dev_vpc.id
}
