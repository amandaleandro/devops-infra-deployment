### **`ci_cd_guide.md`**


# Guia de CI/CD

## Visão Geral
Este guia explica a configuração do pipeline de CI/CD para o projeto usando GitHub Actions. O pipeline é dividido em duas partes: Integração Contínua (CI) e Deploy Contínuo (CD).

## Estrutura de Diretórios
```markdown
ci-cd/
├── .github/
│   └── workflows/
│       ├── ci.yml
│       └── cd.yml
```

## Integração Contínua (CI)
O pipeline de CI lida com a validação do código, como linting e testes unitários.

### Configuração do Workflow de CI
O arquivo `ci.yml` contém o pipeline de CI:
```yaml
name: CI Pipeline

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout do código
      uses: actions/checkout@v2

    - name: Configurar Node.js
      uses: actions/setup-node@v2
      with:
        node-version: '14'

    - name: Instalar dependências
      run: npm install

    - name: Executar testes
      run: npm test
```

### Etapas do Pipeline de CI
1. **Checkout do Código:** Recupera o código do repositório.
2. **Configurar Node.js:** Instala o Node.js para executar os testes.
3. **Instalar Dependências:** Instala as dependências do projeto via `npm install`.
4. **Executar Testes:** Executa os testes definidos no projeto.

## Deploy Contínuo (CD)
O pipeline de CD lida com o deploy da infraestrutura e da aplicação WordPress.

### Configuração do Workflow de CD
O arquivo `cd.yml` gerencia o deploy:
```yaml
name: CD Pipeline

on:
  workflow_dispatch:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout do código
      uses: actions/checkout@v2

    - name: Configurar Terraform
      uses: hashicorp/setup-terraform@v1

    - name: Terraform Init
      run: terraform init
      working-directory: ./terraform

    - name: Terraform Apply
      run: terraform apply -auto-approve
      working-directory: ./terraform
```

### Etapas do Pipeline de CD
1. **Checkout do Código:** Recupera o código do repositório.
2. **Configurar Terraform:** Instala e configura o Terraform.
3. **Terraform Init:** Inicializa a configuração do Terraform.
4. **Terraform Apply:** Aplica o plano do Terraform para fazer o deploy da infraestrutura.

## Como Executar o Pipeline de CI/CD
- O pipeline de CI é executado automaticamente em cada push para a branch `main`.
- O pipeline de CD pode ser acionado manualmente ou em cada push para `main`.

## Gerenciamento de Segredos
Os segredos do GitHub são usados para gerenciar de forma segura as credenciais da AWS necessárias para o deploy. Adicione seus segredos nas configurações do repositório:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

## Solução de Problemas
- **Erros no CI:** Verifique os logs do GitHub Actions para etapas com falhas.
- **Erros no CD:** Certifique-se de que o código do Terraform está correto e que as credenciais da AWS estão configuradas corretamente.


