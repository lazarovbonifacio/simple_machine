# Como subir uma máquina na AWS?

Vamos juntar os requisitos imediatos para a tarefa

## Requisitos

- Credenciais de acesso a uma conta da AWS com permissão
- Terraform ou OpenTofu
- Camada de rede (VPC, SG e Endpoint)
- Instância com IP público

# Passo-a-passo

Antes de tudo, algumas observações importantes

- Não utilize o usuário root da conta

## 1. Criação das credenciais

1. Acesse o painel do IAM
2. Crie um usuário pessoal
3. _Crie uma role de devops_
4. Conceda as permissões necessárias
5. _habilite o acesso do usuário à role_
6. Criar as chaves do usuário

## 2. Criação do módulo TF

1. configurar módulo de VPC
2. configurar módulo de EC2
3. Implantação
4. Instalação NGINX

    ```bash
    sudo dnf install nginx -y
    sudo systemctl enable --now nginx
    ```

## Validação

1. Acesso via SSM Manager
2. Acesso via IP público

# Referências

- https://docs.aws.amazon.com/prescriptive-guidance/latest/patterns/connect-to-an-amazon-ec2-instance-by-using-session-manager.html
- https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-public-parameters-ami.html
- https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions
- https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/5.8.0
- https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/5.8.0

\
📍👦🏻😢👩🏼🙈