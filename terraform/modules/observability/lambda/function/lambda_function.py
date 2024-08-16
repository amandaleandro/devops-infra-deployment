import subprocess
import os

def handler(event, context):
    # Obtendo o caminho para os arquivos Terraform a partir das variáveis de ambiente
    terraform_dir = os.getenv('TERRAFORM_DIR', '/path/to/your/terraform/files')  # Substitua com o caminho correto

    print("Iniciando destruição de todos os recursos via Terraform...")

    # Executando o comando terraform destroy
    try:
        result = subprocess.run(
            ["terraform", "destroy", "-auto-approve"],
            cwd=terraform_dir,
            capture_output=True,
            text=True
        )

        # Exibir a saída do comando
        print(result.stdout)
        print(result.stderr)

        return {
            'statusCode': 200,
            'body': 'Destruição completa executada via Terraform!'
        }
    except Exception as e:
        print(f"Erro durante a execução do terraform destroy: {e}")
        return {
            'statusCode': 500,
            'body': f'Erro ao destruir recursos: {e}'
        }
