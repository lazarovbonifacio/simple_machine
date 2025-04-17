# Como subir uma máquina na AWS?

Vamos precisar juntar os requisitos imediatos para a tarefa

## Requisitos

- Credenciais de acesso a uma conta da AWS com permissão
- Terraform
- VPC (módulo TF)
- instância com IP público

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

## Validação

1. Acesso via SSM Manager
2. Acesso via IP público

\
📍👦🏻😢👩🏼🙈