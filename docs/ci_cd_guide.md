# CI/CD Guide

## Overview
This guide explains the CI/CD pipeline setup for the project using GitHub Actions. The pipeline is divided into two parts: Continuous Integration (CI) and Continuous Deployment (CD).

## Directory Structure
ci-cd/
├── .github/
│ └── workflows/
│ ├── ci.yml
│ └── cd.yml

## Continuous Integration (CI)
The CI pipeline handles code validation, such as linting and unit testing.

### CI Workflow Configuration
The `ci.yml` file contains the CI pipeline:
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
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Set up Node.js
      uses: actions/setup-node@v2
      with:
        node-version: '14'

    - name: Install dependencies
      run: npm install

    - name: Run tests
      run: npm test
CI Pipeline Steps
Checkout Code: Retrieves the code from the repository.
Set Up Node.js: Installs Node.js for running tests.
Install Dependencies: Installs project dependencies via npm install.
Run Tests: Executes any tests defined in the project.
Continuous Deployment (CD)
The CD pipeline handles the deployment of infrastructure and the WordPress application.

CD Workflow Configuration
The cd.yml file handles the deployment:

yaml
Copiar código
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
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Set up Terraform
      uses: hashicorp/setup-terraform@v1

    - name: Terraform Init
      run: terraform init
      working-directory: ./terraform

    - name: Terraform Apply
      run: terraform apply -auto-approve
      working-directory: ./terraform
CD Pipeline Steps
Checkout Code: Retrieves the code from the repository.
Set Up Terraform: Installs and configures Terraform.
Terraform Init: Initializes the Terraform configuration.
Terraform Apply: Applies the Terraform plan to deploy the infrastructure.
How to Run the CI/CD Pipeline
The CI pipeline runs automatically on every push to the main branch.
The CD pipeline can be triggered manually or on every push to main.
Managing Secrets
GitHub Secrets are used to securely manage AWS credentials required for deployment. Add your secrets in the repository settings:

AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
Troubleshooting
CI Errors: Check the GitHub Actions logs for failed steps.
CD Errors: Ensure that your Terraform code is correct and that AWS credentials are correctly configured.