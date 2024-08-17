### **`implementation_guide.md`**

## Introdução
Este guia fornece um processo passo a passo para implementar a infraestrutura DevOps usando Terraform. O projeto automatiza o deploy de uma aplicação WordPress na AWS com recursos adicionais, como escalabilidade, observabilidade e gerenciamento de segredos.

## Pré-requisitos
Antes de começar, certifique-se de ter os seguintes itens instalados e configurados:
- [Terraform](https://www.terraform.io/downloads.html)
- [AWS CLI](https://aws.amazon.com/cli/)
- Credenciais da AWS configuradas (`aws configure`)
```markdown
## Estrutura do Projeto
O projeto segue uma estrutura modular para melhor gerenciamento e escalabilidade:

├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── modules/
│   │   ├── vpc/
│   │   ├── ec2/
│   │   ├── rds/
│   │   ├── eks/
│   │   ├── secrets/
│   │   ├── auto_scaling/
│   │   └── wordpress/
└── observability/
    ├── function/
        ├── lambda_function.py
        ├── requirements.txt
        └── __init__.py
```

## Passos para o Deploy

### 1. Clonar o Repositório
Clone o repositório do projeto para sua máquina local:
```bash
git clone https://github.com/seu-repo/devops-infra-deployment.git
cd devops-infra-deployment/terraform
```

### 2. Inicializar o Terraform
Inicialize o projeto Terraform para baixar os plugins dos provedores:
```bash
terraform init
```

### 3. Revisar e Editar as Variáveis
Edite o arquivo `variables.tf` ou crie um arquivo `terraform.tfvars` para fornecer seus valores personalizados:
```hcl
variable "db_password" {
  description = "Senha para o banco de dados RDS"
  type        = string
}

variable "aws_access_key_id" {
  description = "ID de chave de acesso da AWS"
  type        = string
}

variable "secret_access_key" {
  description = "Chave de acesso secreta da AWS"
  type        = string
}
```

### 4. Aplicar a Configuração do Terraform
Execute o seguinte comando para fazer o deploy da infraestrutura:
```bash
terraform apply
```
Confirme a aplicação digitando "yes" quando solicitado.

### 5. Verificar o Deploy
Após a conclusão do deploy do Terraform, você pode verificar os recursos no Console de Gerenciamento da AWS.

## Componentes da Infraestrutura
- **VPC:** Uma Virtual Private Cloud com sub-redes públicas e privadas.
- **EC2:** Instâncias para hospedar a aplicação WordPress.
- **RDS:** Um banco de dados MySQL para o WordPress.
- **EKS:** Um cluster Kubernetes para workloads containerizados.
- **Gerenciamento de Segredos:** AWS Secrets Manager para gerenciamento seguro de credenciais.
- **Auto Scaling:** Políticas para gerenciar a escalabilidade dos recursos conforme a demanda.

## Monitoramento e Cleanup
A infraestrutura inclui alarmes do CloudWatch e uma função Lambda que dispara a limpeza automática dos recursos após 20 minutos de inatividade.

## Solução de Problemas
- **Erros no Terraform:** Verifique a saída do Terraform para erros específicos e ajuste as variáveis conforme necessário.
- **Erros na AWS:** Certifique-se de que suas credenciais AWS estão configuradas corretamente e possuem as permissões necessárias.
