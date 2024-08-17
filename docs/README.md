
---

# **Documentação do Projeto de Infraestrutura DevOps**

## **Índice**
1. [Visão Geral](#visão-geral)
2. [Estrutura do Projeto](#estrutura-do-projeto)
3. [Componentes Implementados](#componentes-implementados)
   - VPC
   - EC2
   - RDS
   - EKS
   - WordPress
4. [Gestão de Segredos](#gestão-de-segredos)
5. [CI/CD Automatizado](#cicd-automatizado)
   - Integração Contínua (CI)
   - Deploy Contínuo (CD)
6. [Monitoramento e Alarme](#monitoramento-e-alarme)
7. [Escalabilidade e Auto Scaling](#escalabilidade-e-auto-scaling)
8. [Destruição Automática dos Recursos](#destruição-automática-dos-recursos)
9. [Como Usar](#como-usar)
   - Passos para Configuração e Deploy
   - Execução e Destruição Automática
10. [Considerações Finais](#considerações-finais)

---

## **1. Visão Geral**
Este projeto tem como objetivo provisionar uma infraestrutura DevOps completa na AWS utilizando Terraform. Ele automatiza o deploy de uma aplicação WordPress, incluindo recursos para segurança, escalabilidade e observabilidade, além de uma solução CI/CD integrada.

## **2. Estrutura do Projeto**
A estrutura do projeto segue uma organização modular para facilitar a manutenção e a escalabilidade:

```plaintext
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
├── ci-cd/
│   ├── .github/
│   │   └── workflows/
│   │       └── ci.yml
│   │       └── cd.yml
├── docs/
│   ├── README.md
│   ├── implementation_guide.md
│   ├── ci_cd_guide.md
└── observability/
    ├── function/
    │   ├── lambda_function.py
    │   ├── requirements.txt
    │   └── __init__.py
```

## **3. Componentes Implementados**

### **VPC**
Uma Virtual Private Cloud (VPC) foi criada para isolar e segmentar os recursos da AWS. Subnets públicas e privadas foram configuradas com regras de segurança.

### **EC2**
Instâncias EC2 foram configuradas para hospedar o WordPress, com uma instância sendo responsável pelo servidor Apache e PHP.

### **RDS**
Um banco de dados MySQL foi provisionado utilizando o Amazon RDS, com suas credenciais gerenciadas pelo Secrets Manager.

### **EKS**
Um cluster EKS foi criado para suportar a escalabilidade da aplicação, permitindo a orquestração de contêineres.

### **WordPress**
O deploy do WordPress foi automatizado, incluindo a instalação do Apache, PHP e configuração do banco de dados.

## **4. Gestão de Segredos**
O AWS Secrets Manager foi utilizado para gerenciar as senhas e chaves de acesso, integrando diretamente com o Terraform.

## **5. CI/CD Automatizado**
O pipeline de CI/CD foi dividido em duas partes:

### **Integração Contínua (CI)**
- Testes e validações automáticas são executadas no pipeline de CI.
- Isso garante que o código está livre de erros antes do deploy.

### **Deploy Contínuo (CD)**
- Após a aprovação, o Terraform é executado para aplicar as mudanças na infraestrutura.
- O deploy do WordPress é feito de forma automatizada.

## **6. Monitoramento e Alarme**
Utilizei o CloudWatch para monitorar a utilização de CPU das instâncias EC2 e configurar um alarme para altos níveis de uso. Caso o alarme seja acionado, ele pode desencadear uma função Lambda que destrói a infraestrutura após 20 minutos de inatividade.

## **7. Escalabilidade e Auto Scaling**
Políticas de auto scaling foram configuradas tanto para as instâncias EC2 quanto para o cluster EKS, garantindo que a aplicação possa escalar com base na demanda.

## **8. Destruição Automática dos Recursos**
Uma função Lambda foi criada para destruir os recursos após 20 minutos de inatividade, com base nos eventos do CloudWatch.

## **9. Como Usar**

### **Passos para Configuração e Deploy**
1. Clone o repositório.
2. Configure as variáveis de ambiente (AWS access key, secret key, etc.).
3. Execute o Terraform para provisionar a infraestrutura:
   ```bash
   terraform init
   terraform apply
   ```

### **Execução e Destruição Automática**
- A infraestrutura será automaticamente destruída após 20 minutos de inatividade se o alarme for acionado.

## **10. Considerações Finais**
Este projeto demonstra uma solução completa e automatizada para deploy de infraestrutura na AWS, com foco em segurança, escalabilidade e automação de processos.

---
