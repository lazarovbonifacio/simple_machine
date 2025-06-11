# Como subir uma máquina na Azure?

Vamos juntar os requisitos imediatos para a tarefa

# Requisitos

- Conta na Azure com subscrição 
- Cotas de vCPUs para família _Standard Av2_
- Terraform ou OpenTofu
- Instância com IP público

# Passo a passo

## 1. Conta na Azure com subscrição 

1. Faça login no serviço: `az login`
2. Colete o ID da chave e alimente na variável `provider_azurerm_subscription_id`

## 2. Cotas de vCPUs para família _Standard Av2_

1. Procure por 'Quotas' na barra de pesquisa
2. Em 'Settings > My quotas', pesquise por "Av2"
3. Verifique a disponibilidade na região desejada

## 3. Terraform


1. Criar Resource Group
2. configurar módulo de NSG
3. configurar módulo de VNET
4. configurar módulo de VM
5. Implantação

    ```bash
    tofu init
    tofu plan  # verifique o que vai subir
    tofu apply -auto-approve
    ```

## 4. instalação do NGINX

1. Procure por 'virtual machine'
2. Selecion a 'simpleMachine'
3. Em 'Operations > Run command', clique em RunShellScript
4. Copie e cole os comandos abaixo:

    ```bash
    sudo apt update
    sudo apt install nginx -y
    sudo systemctl enable --now nginx
    ```

5. Pressione em 'Run' e aguarde o resultado

## Validação

1. Acesso via IP público

# Referências

- https://registry.terraform.io/modules/Azure/avm-res-network-virtualnetwork/azurerm/latest
- https://github.com/Azure/terraform-azurerm-network-security-group/tree/main
- https://registry.terraform.io/modules/Azure/avm-res-compute-virtualmachine/azurerm/latest

\
📍👦🏻😢👩🏼🙈